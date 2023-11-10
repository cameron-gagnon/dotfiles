package main

import (
	"bufio"
	"flag"
	"fmt"
	"log"
	"os"
	"os/exec"
	"strconv"
	"strings"
)

func main() {
	var filenames string
	var prLink string

	// Parse command line arguments
	flag.StringVar(&filenames, "filenames", "", "Path to filename containing file-list")
	flag.StringVar(&prLink, "pr", "", "GitHub PR link")
	flag.Parse()

	if filenames == "" || prLink == "" {
		log.Fatalf("Input Error: Both filenames and pr flags are required.")
	}

	// Open the file that contains filenames
	file, err := os.Open(filenames)
	if err != nil {
		log.Fatalf("File Error: Failed to open the file %s with error: %s", filenames, err)
	}
	defer file.Close()

	// query to get full list of files in PR. `gh pr view` only returns 100
	// files with no option to paginate the response
	// https://github.com/cli/cli/issues/5368
	query := `query($owner: String!, $repo: String!, $pr: Int!, $endCursor: String) {
		repository(owner: $owner, name: $repo) {
			pullRequest(number: $pr) {
				files(first: 100, after: $endCursor) {
					pageInfo{ hasNextPage, endCursor }
					nodes {
						path
					}
				}
			}
		}
	}`

	parts := strings.Split(prLink, "/")
	owner := parts[3]
	repo := parts[4]
	prNum, err := strconv.Atoi(parts[6])
	if err != nil {
		log.Fatal(err)
	}
	cmd := exec.Command("gh", "api", "graphql", "-f", fmt.Sprintf("query=%s", query), "-F", fmt.Sprintf("owner=%s", owner), "-F", fmt.Sprintf("repo=%s", repo), "-F", fmt.Sprintf("pr=%d", prNum), "--paginate", "--jq", ".data.repository.pullRequest.files.nodes.[].path")

	// Get the output from the command
	output, err := cmd.CombinedOutput()
	if err != nil {
		log.Fatalf("Execution Error: Failed to execute the gh command with output: %s. error: %v", output, err)
	}

	ghFiles := strings.Split(string(output), "\n")

	notFound := false
	// Check each file in the scanner
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		filename := scanner.Text()
		found := false
		// Compare with each file in the GitHub PR
		for _, f := range ghFiles {
			if strings.Contains(f, filename) {
				found = true
				break
			}
		}
		if !found {
			fmt.Printf("❌ %s not found\n", filename)
			notFound = true
		} else {
			fmt.Printf("✅ %s found\n", filename)
		}
	}

	if err := scanner.Err(); err != nil {
		log.Fatalf("Scan Error: Failed to scan the file %s with error: %s", filenames, err)
	}

	if notFound {
		log.Fatalf("❌File Error: Not all files were found in the PR changeset")
	} else {
		log.Print("✅ All files provided were found in the PR!")
	}
}

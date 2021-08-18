#!/bin/bash

ag_shortcuts() {
    orig_ag="/usr/local/bin/ag"
    cmd_output=$(mktemp)

    $orig_ag --color --color-path '1;31' --group ${@} | /usr/bin/env ruby "$HOME/dotfiles/cmd_shortcuts/ag_wrapper.rb" > $cmd_output

    # Fetch list of files from last line of script output
    files="$(cat $cmd_output | \grep '@@filelist@@::' | sed 's%@@filelist@@::%%g')"

    # Export numbered env variables for each file
    local e=1
    env_char=e
    for file in $(echo $files | tr '|' "\n"); do
        export $env_char$e="$file"
        let e++
    done

    # Print status
    cat "$cmd_output" | grep -v '@@filelist@@::'

    rm -f $cmd_output
}
alias ag='ag_shortcuts'

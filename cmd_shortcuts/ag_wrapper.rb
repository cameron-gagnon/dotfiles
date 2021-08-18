#!/usr/bin/env ruby
# encoding: UTF-8

COLORS = {
  :reset => "\033[0m",
  :dark => "\033[2;37m",
}

COLOR_MATCH = /\e\[[0-9;]*[mK]/
COLOR_PATH_MATCH = /\033\[1;31m(.*)\033\[0m\033\[K/

output_files = []

stdin = STDIN.set_encoding(Encoding::ASCII_8BIT)

class FileCounter
  def initialize
    @num_matches = 1
  end

  def print_number
    print "#{COLORS[:dark]}[#{COLORS[:reset]}#{@num_matches}#{COLORS[:dark]}]#{COLORS[:reset]} "
    @num_matches += 1
  end
end

fc = FileCounter.new
while stdin.gets
  matches = $_.match(/^#{COLOR_PATH_MATCH}$/)
  if matches
    fc.print_number
    file = matches[1]
    output_files << file
  end
  puts $_
end

print "@@filelist@@::"

output_files.each_with_index {|f,i|
  # If file starts with a '~', treat it as a relative path.
  # This is important when dealing with symlinks
  print "|" unless i == 0
  print File.join(Dir.pwd, f)
}
puts

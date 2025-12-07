#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '.......S.......
...............
.......^.......
...............
......^.^......
...............
.....^.^.^.....
...............
....^.^...^....
...............
...^.^...^.^...
...............
..^...^.....^..
...............
.^.^.^.^.^...^.
...............'

def draw(line, beams)
  line = line.chars
  beams.each { |beam| line[beam] = '|' unless line[beam] == '^' }
  p line.join
end

def star1(input, debug: false)
  beams = Set[]
  splits = 0

  input.split.each do |line|
    draw(line, beams) if debug
    # Only for first line
    chars = line.chars
    found = chars.index('S')

    if found
      beams << found
      next
    end

    beams.to_a.each do |beam|
      next unless chars[beam] == '^'

      beams.delete(beam)
      beams.merge([beam - 1, beam + 1])
      splits += 1
    end
  end

  splits
end

p "Test: #{star1(test_input, debug: true)} == 21"
p "Star 1: #{star1(INPUT)}"

# def star2(input, debug = false)
# end
#
# p "Test: #{star2(test_input, true)} == x"
# p "Star 2: #{star2(INPUT)}"

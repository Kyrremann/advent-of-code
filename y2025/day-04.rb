#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.'

def too_many_rolls(map, row, col)
  directions = [
    [-1, -1], [-1, 0], [-1, 1],
    [ 0, -1],          [ 0, 1],
    [ 1, -1], [ 1, 0], [ 1, 1]
  ]

  directions.select do |dy, dx|
    y = dy + row
    x = dx + col

    y.between?(0, map.size - 1) &&
      x.between?(0, map[0].size - 1) &&
      map[y][x] == '@'
  end
end

def star1(input, debug: false)
  p input if debug
  map = input.split.map(&:chars)
  count = 0
  (0...map.length).each do |y|
    (0...map[y].length).each do |x|
      p "#{y},#{x}: #{map[y][x]}" if debug
      count += 1 if map[y][x] == '@' && too_many_rolls(map, y, x).count < 4
    end
  end
  count
end

p "Test: #{star1(test_input, debug: false)} == 13"
p "Star 1: #{star1(INPUT)}"

# def star2(input, debug: false)
# end
#
# p "Test: #{star2(test_input, debug: true)} == x"
# p "Star 2: #{star2(INPUT)}"

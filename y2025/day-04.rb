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

def find_roll(map, row, col)
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

def count_and_ship(map)
  ship_it = []
  (0...map.length).each do |y|
    (0...map[y].length).each do |x|
      next if map[y][x] == '.' || too_many_rolls(map, y, x).count > 3

      ship_it << [y, x]
    end
  end

  ship_it
end

def star2(input, debug: false)
  map = input.split.map(&:chars)
  count = 0
  loop do
    ship_it = count_and_ship(map)
    count += ship_it.size
    ship_it.each do |y, x|
      map[y][x] = '.'
    end

    break if ship_it.empty?
  end

  count
end

p "Test: #{star2(test_input, debug: true)} == 43"
p "Star 2: #{star2(INPUT)}"

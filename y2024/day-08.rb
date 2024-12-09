#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............'

def format(input)
  input.split("\n")
end

def antinode(input, y, x, yy, xx)
  diff_y = (y - yy).abs
  diff_x = (x - xx).abs
  if x > xx
    yyy = y - diff_y
    xxx = x + diff_x
    input[yyy][xxx] = '#' if yyy >= 0 && yyy < input.length && xxx >= 0 && xxx < input[yyy].length

    yyy = yy + diff_y
    xxx = xx - diff_x
    input[yyy][xxx] = '#' if yyy >= 0 && yyy < input.length && xxx >= 0 && xxx < input[yyy].length
  else
    yyy = y - diff_y
    xxx = x - diff_x
    input[yyy][xxx] = '#' if yyy >= 0 && yyy < input.length && xxx >= 0 && xxx < input[yyy].length

    yyy = yy + diff_y
    xxx = xx + diff_x
    input[yyy][xxx] = '#' if yyy >= 0 && yyy < input.length && xxx >= 0 && xxx < input[yyy].length
  end
end

def find(freq, y, x, input, antinodes, debug)
  print freq, ': ', y, ',', x, "\n" if debug
  (y + 1...input.length).each do |yy|
    (0...input[yy].length).each do |xx|
      antenna = input[yy][xx]
      next unless antenna == freq

      print "\t", yy, ',', xx, "\n" if debug
      antinode(antinodes, y, x, yy, xx)
      p 'Found one, time to create antinodes!' if debug
      (0...input.length).each { |y| print input[y], ' ', antinodes[y], "\n" } if debug
    end
  end
end

def star1(input, debug = false)
  input = format(input)
  antinodes = input.map(&:clone)
  (0...input.length).each do |y|
    (0...input[y].length).each do |x|
      antenna = input[y][x]
      next if ['.', '#'].include?(antenna)

      find(antenna, y, x, input, antinodes, debug)
    end
  end

  antinodes.join.count('#')
end

p "Test: #{star1(test_input, true)} == 14"
p "Star 1: #{star1(INPUT)}"

def antinode(input, y, x, yy, xx)
  input[y][x] = '#'
  input[yy][xx] = '#'
  diff_y = (y - yy).abs
  diff_x = (x - xx).abs
  if x > xx
    yyy = y - diff_y
    xxx = x + diff_x
    while yyy >= 0 && yyy < input.length && xxx >= 0 && xxx < input[yyy].length
      input[yyy][xxx] = '#'
      yyy -= diff_y
      xxx += diff_x
    end

    yyy = yy + diff_y
    xxx = xx - diff_x
    while yyy >= 0 && yyy < input.length && xxx >= 0 && xxx < input[yyy].length
      input[yyy][xxx] = '#'
      yyy += diff_y
      xxx -= diff_x
    end
  else
    yyy = y - diff_y
    xxx = x - diff_x
    while yyy >= 0 && yyy < input.length && xxx >= 0 && xxx < input[yyy].length
      input[yyy][xxx] = '#'
      yyy -= diff_y
      xxx -= diff_x
    end

    yyy = yy + diff_y
    xxx = xx + diff_x
    while yyy >= 0 && yyy < input.length && xxx >= 0 && xxx < input[yyy].length
      input[yyy][xxx] = '#'
      yyy += diff_y
      xxx += diff_x
    end
  end
end

def star2(input, debug = false)
  star1(input, debug)
end

p "Test: #{star2(test_input, true)} == 34"
p "Star 2: #{star2(INPUT)}"

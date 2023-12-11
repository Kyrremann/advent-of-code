#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).split('.').first}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....'

def expand_space(space)
  space_to_add = []

  space.each_with_index do |line, index|
    space_to_add << index if line.all? { |area| area == '.' }
  end

  space_to_add.each_with_index do |index, i|
    space.insert(index + i, Array.new(space.first.size, '.'))
  end

  space_to_add = []
  space.first.size.times do |index|
    space_to_add << index if space.all? { |line| line[index] == '.' }
  end

  space_to_add.each_with_index do |index, i|
    space.each { |line| line.insert(index + i, '.') }
  end

  space
end

def find_galaxies(space)
  galaxies = []
  space.each_with_index do |line, y|
    line.each_with_index do |area, x|
      next if area == '.'

      galaxies << [x, y]
    end
  end

  galaxies
end

def distance(start, finish)
  (start[0] - finish[0]).abs + (start[1] - finish[1]).abs
end

def find_shortest_path(start, galaxies)
  return 0 if galaxies.nil? || galaxies.empty?

  galaxies.sum { |galaxy| distance(start, galaxy) }
end

def star1(input)
  space = expand_space(input.split("\n").map(&:chars))
  galaxies = find_galaxies(space)
  galaxies.each_with_index.sum do |galaxy, index|
    find_shortest_path(galaxy, galaxies[(index + 1)...])
  end
end

p "Test: #{star1(test_input)} == 374"

print 'Star 1: '
p star1(INPUT)

def star2(input)
end

p "Test: #{star2(test_input)} == 46"

print 'Star 2: '
p star2(INPUT)

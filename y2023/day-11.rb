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
    space_to_add << index unless line.any? { |area| area == '#' }
  end

  space_to_add.each_with_index do |index, i|
    space.insert(index + i, Array.new(space.first.size, '.'))
  end

  space_to_add = []
  space.first.size.times do |index|
    space_to_add << index unless space.any? { |line| line[index] == '#' }
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

def expand_old_space(space)
  y = []
  space.each_with_index do |line, index|
    y << index unless line.any? { |area| area == '#' }
  end

  x = []
  space.first.size.times do |index|
    x << index unless space.any? { |line| line[index] == '#' }
  end

  [x.sort, y.sort]
end

# x, y
def distance_old(start, finish, expanded_x, expanded_y)
  size = 1_000_000
  shortest = (start[0] - finish[0]).abs + (start[1] - finish[1]).abs

  direction_x = [start[0], finish[0]].sort
  expanded_space_x = expanded_x.select { |x| x > direction_x.first && x < direction_x.last }

  direction_y = [start[1], finish[1]].sort
  expanded_space_y = expanded_y.select { |y| y > direction_y.first && y < direction_y.last }

  shortest +
    (expanded_space_y.size * size) - expanded_space_y.size +
    (expanded_space_x.size * size) - expanded_space_x.size
end

def find_shortest_path_in_old_space(start, galaxies, expanded_x, expanded_y)
  return 0 if galaxies.nil? || galaxies.empty?

  galaxies.sum { |galaxy| distance_old(start, galaxy, expanded_x, expanded_y) }
end

def star2(input)
  space = input.split("\n").map(&:chars)
  expanded_x, expanded_y = expand_old_space(space)

  galaxies = find_galaxies(space)
  galaxies.each_with_index.sum do |galaxy, index|
    find_shortest_path_in_old_space(galaxy, galaxies[(index + 1)...], expanded_x, expanded_y)
  end
end

p "Test: #{star2(test_input)} == ???"

print 'Star 2: '
p star2(INPUT)

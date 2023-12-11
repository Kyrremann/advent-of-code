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

def distance(x, y, finish_x, finish_y)
  (x - finish_x).abs + (y - finish_y).abs
end

def find_shortest_path(index, start, galaxies)
  return 0 if galaxies.nil? || galaxies.empty?

  x, y = start

  galaxies.each_with_index.sum do |galaxy, gnum|
    finish_x, finish_y = galaxy
    # p "Start(#{index + 1}): #{start} - Finish(#{index + gnum + 2}): #{galaxy} - Distance: #{distance(x, y, finish_x, finish_y)}"
    distance(x, y, finish_x, finish_y)
  end
end

def star1(input)
  # input.split("\n").map(&:chars).each { |line| p line.join }
  # p '---'
  space = expand_space(input.split("\n").map(&:chars))
  # index = 0
  # space.each { |line| p(line.map { |area| area == '.' ? area : index += 1 }.join) }
  galaxies = find_galaxies(space)
  galaxies.each_with_index.sum do |galaxy, index|
    find_shortest_path(index, galaxy, galaxies[(index + 1)...])
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

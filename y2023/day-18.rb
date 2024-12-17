#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).split('.').first}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = 'R 6 (#70c710)
D 5 (#0dc571)
L 2 (#5713f0)
D 2 (#d2c081)
R 2 (#59c680)
D 2 (#411b91)
L 5 (#8ceee2)
U 2 (#caa173)
L 1 (#1b58a2)
U 2 (#caa171)
R 2 (#7807d2)
U 3 (#a77fa3)
L 2 (#015232)
U 2 (#7a21e3)'

def star1(input)
  coordinates = []
  x = 0
  y = 0

  input.split("\n").map do |line|
    direction, length, = line.split(' ')

    length.to_i.times do
      case direction
      when 'R'
        x += 1
      when 'L'
        x -= 1
      when 'U'
        y -= 1
      when 'D'
        y += 1
      end
      coordinates << [x, y]
    end
  end

  p coordinates
  min_x = coordinates.map(&:first).min.abs
  min_y = coordinates.map(&:last).min.abs
  coordinates.map! { |coordinate| [coordinate.first + min_x, coordinate.last + min_y] }

  p coordinates
  max_x = coordinates.map(&:first).max
  max_y = coordinates.map(&:last).max

  terrain = Array.new(max_y + 1) { Array.new(max_x + 1, '.') }
  coordinates.each do |coordinate|
    terrain[coordinate.last][coordinate.first] = '#'
  end

  puts terrain.map(&:join).join("\n")
end

p "Test: #{star1(test_input)} == 62"

print 'Star 1: '
p star1(INPUT)

def star2(input)
end

p "Test: #{star2(test_input)} == 46"

print 'Star 2: '
p star2(INPUT)

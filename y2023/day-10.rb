#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).split('.').first}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '7-F7-
.FJ|7
SJLL7
|F--J
LJ.LJ'

def find_start(matrix)
  y = matrix.index { |line| line.include?('S') }
  x = matrix[y].index('S')
  [x, y]
end

def directions(direction, pipe)
  {
    'N' => {
      'F' => 'E',
      '|' => 'N',
      '7' => 'W'
    },
    'E' => {
      'J' => 'N',
      '-' => 'E',
      '7' => 'S'
    },
    'S' => {
      'L' => 'E',
      '|' => 'S',
      'J' => 'W'
    },
    'W' => {
      'F' => 'S',
      '-' => 'W',
      'L' => 'N'
    }
  }[direction][pipe]
end

def next_move(direction)
  {
    'N' => [0, -1],
    'E' => [1, 0],
    'S' => [0, 1],
    'W' => [-1, 0]
  }[direction]
end

def move(matrix, x, y, direction)
  pipe = matrix[y][x]
  direction = directions(direction, pipe)
  move = next_move(direction)
  x += move.first
  y += move.last
  [x, y, direction]
end

def star1(input, start_tile, cw_direction, ccw_direction)
  matrix = input.split(/\n/).map(&:chars)

  x, y = find_start(matrix)
  matrix[y][x] = start_tile

  # counter wise
  cw_x = x
  cw_y = y

  # counter clock wise
  ccw_x = x
  ccw_y = y

  steps = 0
  loop do
    steps += 1

    cw_x, cw_y, cw_direction = move(matrix, cw_x, cw_y, cw_direction)
    ccw_x, ccw_y, ccw_direction = move(matrix, ccw_x, ccw_y, ccw_direction)

    break if cw_x == ccw_x && cw_y == ccw_y
  end

  steps
end

p "Test: #{star1(test_input, 'F', 'N', 'W')} == 8"

print 'Star 1: '
p star1(INPUT, '7', 'N', 'E')

def star2(input)
end

p "Test: #{star2(test_input)} == 46"

print 'Star 2: '
p star2(INPUT)

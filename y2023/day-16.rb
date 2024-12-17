#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).split('.').first}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '.|...\....
|.-.\.....
.....|-...
........|.
..........
.........\
..../.\\..
.-.-/..|..
.|....-|.\
..//.|....'

def move(x, y, direction)
  case direction
  when :north
    y -= 1
  when :south
    y += 1
  when :east
    x += 1
  when :west
    x -= 1
  end

  [x, y]
end

def mirror(tile, x, y, direction)
  case direction
  when :north
  end
end

def splitter_dash(tile, x, y, direction)
  case direction
  when :north
    
  when :east
    x += 1
  when :south
  when :west
    x -= 1
  end

  [x, y]
end

def shoot_laser(input, x, y, direction, map)
  loop do
    tile = input[y][x]
    x, y = case tile
           when '|'
           when '-'
             splitter_dash(tile, x, y, direction)
           when '/', '\\'
             mirror(tile, x, y, direction)
           when '.'
             move(x, y, direction)
           end
  end
end

def star1(input)
  input = input.split("\n").map(&:chars)
  map = input.map(&:dup)
  shoot_laser(input, 0, 0, :east, map)
  map.count('#')
end

p "Test: #{star1(test_input)} == 46"
exit
print 'Star 1: '
p star1(INPUT)

def star2(input)
end

p "Test: #{star2(test_input)} == 46"

print 'Star 2: '
p star2(INPUT)

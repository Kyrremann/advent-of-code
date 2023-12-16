#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).split('.').first}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = 'O....#....
O.OO#....#
.....##...
OO.#O....O
.O.....O#.
O.#..O.#.#
..O..#O..O
.......O..
#....###..
#OO..#....'

def next_stone(input, x, y)
  while y < input.length
    return nil if input[y][x] == '#'

    return y if input[y][x] == 'O'

    y += 1
  end
end

def star1(input)
  input = input.split("\n").map(&:chars)
  input.first.length.times do |x|
    input.length.times do |y|
      next unless input[y][x] == '.'

      index = next_stone(input, x, y)
      if index
        input[y][x] = 'O'
        input[index][x] = '.'
      end
    end
  end

  input.each_with_index.sum do |row, index|
    (input.length - index) * row.count('O')
  end
end

p "Test: #{star1(test_input)} == 136"

print 'Star 1: '
p star1(INPUT)

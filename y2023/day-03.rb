#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).split('.').first}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..'

def near_pattern(matrix, x, y, pattern)
  return true, x - 1, y- 1 if y.positive? && x.positive? && matrix[y - 1][x - 1] =~ pattern
  return true, x, y - 1 if y.positive? && matrix[y - 1][x] =~ pattern
  return true, x + 1, y - 1 if y.positive? && x < matrix.first.length - 1 && matrix[y - 1][x + 1] =~ pattern
  return true, x + 1, y if x < matrix.first.length - 1 && matrix[y][x + 1] =~ pattern
  return true, x - 1, y if x.positive? && matrix[y][x - 1] =~ pattern
  return true, x - 1, y + 1 if y < matrix.length - 1 && x.positive? && matrix[y + 1][x - 1] =~ pattern
  return true, x, y + 1 if y < matrix.length - 1 && matrix[y + 1][x] =~ pattern
  return true, x + 1, y + 1 if y < matrix.length - 1 && x < matrix.first.length - 1 && matrix[y + 1][x + 1] =~ pattern

  [false, -1, -1]
end

def find_number(matrix, x, y)
  pattern = /[0-9]/
  x -= 1 while matrix[y][x - 1] =~ pattern
  number = ''
  while matrix[y][x] =~ pattern
    number += matrix[y][x]
    x += 1
  end

  [number.to_i, x + 1]
end

def star1(input)
  matrix = input.split(/\n/).map(&:chars)

  sum = 0
  x = 0
  y = 0
  while y < matrix.length
    while x < matrix.first.length
      if matrix[y][x] == '.'
        x += 1
        next
      end

      if near_pattern(matrix, x, y, /[^0-9.]/).first
        number, next_x = find_number(matrix, x, y)
        # p "Found number #{number} at #{x},#{y}. Next x: #{next_x}"
        sum += number
        x = next_x
      else
        x += 1
      end
    end

    y += 1
    x = 0
  end

  sum
end

p "Test: #{star1(test_input)} == 4361"

print 'Star 1: '
p star1(INPUT)

def star2(input)
  matrix = input.split(/\n/).map(&:chars)

  map = {}
  x = 0
  y = 0
  while y < matrix.length
    while x < matrix.first.length
      if matrix[y][x] == '.'
        x += 1
        next
      end

      found, px, py = near_pattern(matrix, x, y, /\*/)
      if found
        number, next_x = find_number(matrix, x, y)
        # p "Found number #{number} at #{x},#{y}. Next x: #{next_x}"
        map["#{px},#{py}"] ||= []
        map["#{px},#{py}"] << number
        x = next_x
      else
        x += 1
      end
    end

    y += 1
    x = 0
  end

  map.select { |_, v| v.length == 2 }.values.map { |v| v.inject(:*) }.sum
end

p "Test: #{star2(test_input)} == 467835"

print 'Star 2: '
p star2(INPUT)

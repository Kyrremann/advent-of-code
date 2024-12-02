#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '3   4
4   3
2   5
1   3
3   9
3   3'

def format(input)
  left = []
  right = []
  input.split("\n").each do |line|
    a, b = line.split('   ').map { |v| v.to_i }
    left << a
    right << b
  end

  [left, right]
end

def star1(input)
  left, right = format(input)
  left.sort!
  right.sort!

  left.each_with_index.map { |value, index| (value - right[index]).abs }.sum
end

p "Test: #{star1(test_input)} == 11"

p "Star 1: #{star1(INPUT)}"

def star2(input)
  left, right = format(input)

  left.map { |value| value * right.count(value) }.sum
end

p "Test: #{star2(test_input)} == 31"

p "Star 2: #{star2(INPUT)}"

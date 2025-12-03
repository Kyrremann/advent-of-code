#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '987654321111111
811111111111119
234234234234278
818181911112111'

def max(array, history)
  max = -1
  array.each_with_index do |v, i|
    next if history.include?(i)

    max = [v, i] if v > max[0]
  end

  max
end

def star1(input, debug: false)
  history = []
  input.split.map do |line|
    chars = line.chars.map(&:to_i)
    m1 = max(chars, history)
    m2 = chars[m1.last + 1..].max

    if m2.nil?
      history << m1.last
      redo
    end

    [m1.first, m2].join.to_i
  end.sum
end

p "Test: #{star1(test_input, debug: true)} == 357"
p "Star 1: #{star1(INPUT)}"

# def star2(input, debug: false)
# end

# p "Test: #{star2(test_input, debug: true)} == x"
# p "Star 2: #{star2(INPUT)}"

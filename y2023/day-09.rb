#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).split('.').first}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45'

def find_next_value(input)
  return 0 if input.all?(&:zero?)

  next_value = find_next_value(input.each_with_index.map do |number, index|
                                 next if index == input.size - 1

                                 input[index + 1] - number
                               end.compact)

  input.last + next_value
end

def star1(input)
  input.split("\n").sum do |line|
    find_next_value(line.split(' ').map(&:to_i))
  end
end

p "Test: #{star1(test_input)} == 114"

print 'Star 1: '
p star1(INPUT)

def find_previous_value(input)
  return 0 if input.all?(&:zero?)

  previous_value = find_previous_value(input.each_with_index.map do |number, index|
                                         next if index == input.size - 1

                                         input[index + 1] - number
                                       end.compact)

  input.first - previous_value
end

def star2(input)
  input.split("\n").sum do |line|
    find_previous_value(line.split(' ').map(&:to_i))
  end
end

p "Test: #{star2(test_input)} == 2"

print 'Star 2: '
p star2(INPUT)

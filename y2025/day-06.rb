#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  '

def columnizer(input)
  problems = []
  operators = []
  input.split("\n") do |line|
    line.split.each_with_index do |number, x|
      problems[x] ||= []

      if ['*', '+'].include?(number)
        operators[x] = number
      else
        problems[x] << number.to_i
      end
    end
  end

  [problems, operators]
end

def star1(input, debug: false)
  problems, operators = columnizer(input)
  sum = 0
  operators.each_with_index do |operator, index|
    sum += case operator
    when "*"
      problems[index].inject(:*)
    when '+'
      problems[index].sum
    end
  end

  sum
end

p "Test: #{star1(test_input, debug: true)} == 4277556"
p "Star 1: #{star1(INPUT)}"

# 123
#  45
#   6
#
# 356
#  24
#   1

def star2(input, debug = false)
  problems, operators = columnizer(input)
  problems.each do |problem|
    modified = problem.map(&:to_s).map(&:chars)

    maths = []
    (0...problem.size).each do |i|
      maths[i] = modified.map(&:pop).join.to_i
    end

    p maths
  end
end

p "Test: #{star2(test_input, true)} == 3263827"
# p "Star 2: #{star2(INPUT)}"

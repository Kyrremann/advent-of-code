#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '123 328  51 64
 45 64  387 23
  6 98  215 314
*   +   *   +'

def star1(input, debug: false)
  problems = []
  input.split("\n") do |line|
    line.split.each_with_index do |number, x|
      problems[x] ||= []

      if ['*', '+'].include?(number)
        problems[x] << number
      else
        problems[x] << number.to_i
      end
    end
  end
  problems.sum do |problem|
    operator = problem.pop
    case operator
    when '*'
      problem.inject(:*)
    when '+'
      problem.sum
    end
  end
end

p "Test: #{star1(test_input, debug: true)} == 4277556"
p "Star 1: #{star1(INPUT)}"

# def star2(input, debug = false)
# end
#
# p "Test: #{star2(test_input, true)} == x"
# p "Star 2: #{star2(INPUT)}"

#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9'

def format(input)
  input.split("\n").map { |line| line.split(' ').map { |v| v.to_i } }
end

def star1(input)
  format(input).select do |reports|
    cons = reports.each_cons(2)
    (cons.all? { |a, b| a < b } || cons.all? { |a, b| a > b }) && cons.all? do |a, b|
      diff = (a - b).abs
      diff >= 1 && diff <= 3
    end
  end.count
end

p "Test: #{star1(test_input)} == 2"
p "Star 1: #{star1(INPUT)}"

def star2(input)
  format(input).select do |reports|
    next true if (reports == reports.sort || reports == reports.sort.reverse) &&
                 (reports.each_cons(2).count do |a, b|
                   a == b
                 end < 2) &&
                 (reports.each_cons(2).all? do |a, b|
                    diff = (a - b).abs
                    diff >= 0 && diff <= 3
                  end)

    reports.each_with_index.any? do |_, index|
      cons = reports.reject.with_index { |v, i| i == index }.each_cons(2)
      (cons.all? { |a, b| a < b } || cons.all? { |a, b| a > b }) && cons.all? do |a, b|
        diff = (a - b).abs
        diff >= 1 && diff <= 3
      end
    end
  end.count
end

p "Test: #{star2(test_input)} == 4"
p "Star 2: #{star2(INPUT)}"

#!/usr/bin/env ruby
# frozen_string_literal: true

require 'time'

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
'

def format(input)
  input.split("\n").map { |line| line.split(': ') }
end

def star1(input, debug = false)
  input = format(input)
  input.select do |row|
    eval = row[0].to_i
    numbers = row[1].split.map(&:to_i)

    if debug
      p Time.now
      print eval, ': ', numbers, "\n"
    end

    def tree(eval, numbers)
      return eval == numbers.first if numbers.size == 1

      n = numbers.pop
      s = numbers.pop

      tree(eval, numbers + [(n + s)]) || tree(eval, numbers + [(n * s)])
    end

    tree(eval, numbers.reverse)
  end.map { |row| row[0].to_i }.sum
end

p "Test: #{star1(test_input, true)} == 3749"
p "Star 1: #{star1(INPUT)}"

def star2(input, debug = false)
  input = format(input)
  input.select do |row|
    eval = row[0].to_i
    numbers = row[1].split.map(&:to_i)

    if debug
      p Time.now
      print eval, ': ', numbers, "\n"
    end

    def tree(eval, numbers)
      return eval == numbers.first if numbers.size == 1

      n = numbers.pop
      s = numbers.pop

      tree(eval, numbers + [(n + s)]) ||
        tree(eval, numbers + [(n * s)]) ||
        tree(eval, numbers + ["#{n}#{s}".to_i])
    end

    tree(eval, numbers.reverse)
  end.map { |row| row[0].to_i }.sum
end

p "Test: #{star2(test_input, true)} == 11387"
p "Star 2: #{star2(INPUT)}"

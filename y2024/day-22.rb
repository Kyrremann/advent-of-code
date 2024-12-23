#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '1
10
100
2024'

def mix(secret, n)
  secret ^ n
end

def prune(secret)
  secret % 16_777_216
end

def secret(number)
  number = prune(mix(number, number * 64))
  number = prune(mix(number, (number / 32.0).floor))
  prune(mix(number, number * 2048))
end

def star1(input, debug = false)
  numbers = input.split("\n").map(&:to_i)

  numbers.map do |number|
    print 'Init: ', number if debug
    2000.times do
      number = secret(number)
    end
    print ', new: ', number, "\n" if debug

    number
  end.sum
end

p "Test: #{star1(test_input, true)} == 37327623"
p "Star 1: #{star1(INPUT)}"

def star2(input, debug = false)
  numbers = input.split("\n").map(&:to_i)

  numbers.map do |number|
    # print 'Init: ', number if debug
    print 'Number: ', number, ' -> ', number.digits.first, "\n"
    changes = [[number.digits.first, 3]]

    # 2000.times do
    9.times do
      number = secret(number)

      print 'Number: ', number, ' -> ', number.digits.first, "\n"
      # [3, -3, 9, -4,  8,-4,10, -6,10,-8
      # [3, -3, 6, -1, -1, 0, 2, -2, 0, 2
      ones = number.digits.first
      last = changes.last.first
      diff = ones < last ? ones - last : (last - ones).abs
      print last, ' compared to ', ones, ' = ', diff, "\n"

      changes << [ones, diff]
    end

    # print ', new: ', number, "\n" if debug

    p changes
    p changes.map(&:first)
    p changes.map(&:last)
    p max = changes[3...-1].max { |a, b| a[0] <=> b[0] }
    p index = changes[4...-1].index { |values, changes| values == max[0] }
    p changes[index - 4, 4]
    exit
  end.sum
end

p "Test: #{star2('123', true)} == x"
p "Test: #{star2(test_input, true)} == 23"
# p "Star 2: #{star2(INPUT)}"

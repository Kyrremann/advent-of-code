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

# def star2(input, debug = false)
# end
#
# p "Test: #{star2(test_input, true)} == x"
# p "Star 2: #{star2(INPUT)}"

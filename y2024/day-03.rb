#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = 'xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))'

def star1(input)
  input.scan(/mul\((\d{1,3}),(\d{1,3})\)/).map do |a|
    a.map(&:to_i).reduce(&:*)
  end.sum
end

p "Test: #{star1(test_input)} == 161"
p "Star 1: #{star1(INPUT)}"

test_input = 'xmul(2,4)&mul[3,7]!^don\'t()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))'

def star2(input)
  index = 0
  keep = true
  mul = []

  while matchdata = input.match(/mul\((\d{1,3}),(\d{1,3})\)|do\(\)|don't\(\)/, index)
    match = matchdata.match(0)

    if match == "don't()"
      keep = false
    elsif match == 'do()'
      keep = true
    end

    mul << matchdata.captures if keep
    index = matchdata.end(0)
  end

  mul.sum do |a|
    a.map(&:to_i).reduce(&:*)
  end
end

p "Test: #{star2(test_input)} == 48"
p "Star 2: #{star2(INPUT)}"

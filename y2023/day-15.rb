#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).split('.').first}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = 'rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7'

def hash_it(input, current)
  input.chars.each do |char|
    current += char.ord
    current *= 17
    current = current.%(256)
  end

  current
end

def star1(input)
  input = input.strip.split(',')
  input.sum do |value|
    hash_it(value, 0)
  end
end

p "Test: #{star1('HASH')} == 52"
p "Test: #{star1(test_input)} == 1320"

print 'Star 1: '
p star1(INPUT)

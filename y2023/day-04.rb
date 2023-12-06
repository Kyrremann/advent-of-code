#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).split('.').first}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = 'Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11'

def star1(input)
  input.split(/\n/).sum do |row|
    winnings, yours = row.split(/Card \d+:/).last.split(' | ').map(&:split)
    numbers = yours.select { |v| winnings.include?(v) }.size
    if numbers.zero?
      0
    elsif numbers.size == 1
      1
    else
      2**(numbers - 1)
    end
  end
end

p "Test: #{star1(test_input)} == 142"

print 'Star 1: '
p star1(INPUT)

def star2(input)
  input = input.split(/\n/)
  cards = input.size
  input.each do |row|
    id, rest = row.split(/:/)
    id = id.split.last.to_i
    winnings, yours = rest.split(' | ').map(&:split)
    numbers = yours.select { |v| winnings.include?(v) }.size
    numbers.times do |n|
      n += id
      break if n > cards

      input << input[n]
    end
  end
  input.size
end

p "Test: #{star2(test_input)} == 30"

print 'Star 2: '
p star2(INPUT)

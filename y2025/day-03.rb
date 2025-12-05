#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '987654321111111
811111111111119
234234234234278
818181911112111'

def max(array, history)
  max = []
  array.each_with_index do |v, i|
    next if history.include?(i)

    max = [v, i] if v > (max.first || -1)
  end

  max
end

def solve(chars, history: [])
  m = max(chars, history)
  m2 = max(chars[m.last + 1..], [])

  if m2.empty?
    history << m.last
    return solve(chars, history: history)
  end

  [m, m2]
end

def star1(input, debug: false)
  input.split.map do |fresh|
    solve(fresh.chars.map(&:to_i)).map(&:first).join.to_i
  end.sum
end

p "Test: #{star1(test_input, debug: true)} == 357"
p "Star 1: #{star1(INPUT)}"

def solve(chars, history, place)
  return '' if place < 1

  m = max(chars, history)
  history << m.last
  p m
  place -= 1 unless m.last > chars.length - place
  m.first.to_s + solve(chars, history, place) # if m1.last > chars.length - place)
end

def star2(input, debug: false)
  input.split.map do |fresh|
    chars = fresh.chars.map(&:to_i)
    p solve(chars, [], 12).to_i # .map(&:first).join.to_i
  end.sum
end

p "Test: #{star2(test_input, debug: true)} == 3121910778619"
# p "Star 2: #{star2(INPUT)}"

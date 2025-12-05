#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '3-5
10-14
16-20
12-18

1
5
8
11
17
32'

def star1(input, debug = false)
  freshness, ingredients = input.split("\n\n")

  freshness = freshness.split.map do |fresh|
    first, last = fresh.split('-').map(&:to_i)
    (first..last)
  end

  ingredients.split.map(&:to_i).select do |ingredient|
    freshness.any? { |range| range.include?(ingredient) }
  end.count
end

p "Test: #{star1(test_input, true)} == 3"
p "Star 1: #{star1(INPUT)}"

def extend_range(freshness, fresh)
  ranges = freshness.select do |inner|
    inner.include?(fresh.first) || inner.include?(fresh.last)
  end

  ranges.each do |inner|
    next if inner == fresh

    return ([inner.first, fresh.first].min..[inner.last, fresh.last].max), inner
  end
end

def freshes(freshness)
  freshness.each do |fresh|
    extended, remove = extend_range(freshness, fresh)
    next unless remove

    freshness << extended
    freshness.delete(remove)
    freshness.delete(fresh)
    return false
  end

  true
end

def star2(input, debug = false)
  freshness, = input.split("\n\n")

  freshness = freshness.split.map do |fresh|
    first, last = fresh.split('-').map(&:to_i)
    (first..last)
  end

  loop do
    break if freshes(freshness)
  end

  freshness.each do |f|
    p f
  end

  freshness.sum(&:count)
end

p "Test: #{star2(test_input, true)} == 14"
p "Star 2: #{star2(INPUT)}"

# 27060 40493 49842
# 20638 34571 55276
# 19288 31118 94978

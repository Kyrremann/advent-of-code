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

def find(ranges, range)
  ranges.select do |r|
    next false if range == r

    range.include?(r.first) ||
      range.include?(r.last)
  end
end

def freshness(ranges)
  ranges.each do |original|
    found = find(ranges, original)
    next if found.empty?

    range = original
    found.each do |r|
      ranges.delete(r)
      range = ([range.first, r.first].min..[range.last, r.last].max)
    end

    ranges.delete(original)
    ranges << range
  end
end

def star2(input, debug = false)
  ranges, = input.split("\n\n")

  ranges = ranges.split.map do |fresh|
    first, last = fresh.split('-').map(&:to_i)
    (first..last)
  end

  ranges.sort! { |a, b| a.first <=> b.first }

  ranges = freshness(ranges)

  ranges.sum(&:count)
end

p "Test: #{star2(test_input, true)} == 14"
p "Star 2: #{star2(INPUT)}"

# 27060 40493 49842
# 20638 34571 55276
# 19288 31118 94978
# 38458 37166 44056
# 37436 03876 06186

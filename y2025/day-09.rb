#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '7,1
11,1
11,7
9,7
9,5
2,5
2,3
7,3'

def distance(ax, ay, bx, by)
  Math.sqrt((ax - ay)**2 + (bx - by)**2)
end

def rectangle(ax, ay, bx, by)
  ((ax - bx).abs + 1) * ((ay - by).abs + 1)
end

def star1(input, debug: false)
  coordinates = input.split.map { |line| line.split(',').map(&:to_i) }

  coordinates.map do |a|
    coordinates.map do |b|
      next if a == b

      tiles = rectangle(a.first, a.last, b.first, b.last)
      p "#{a}, #{b}: #{tiles} tiles" if debug
      tiles
    end.compact.max
  end.max
end

p "Test: #{star1(test_input, debug: true)} == 50"
p "Star 1: #{star1(INPUT)}"

# def star2(input, debug: false)
# end
#
# p "Test: #{star2(test_input, debug: true)} == x"
# p "Star 2: #{star2(INPUT)}"

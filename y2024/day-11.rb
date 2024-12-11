#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '125 17'

def star1(input, blinks, debug = false)
  stones = input.split.map(&:to_i)
  print 'Blinked 0 times: ', stones, "\n" if debug
  (0...blinks).each do |blinked|
    tmp = []
    stones.each_with_index do |stone, i|
      next tmp << 1 if stone == 0

      sstone = stone.to_s
      next tmp << stone * 2024 if sstone.length.odd?

      half = (sstone.length / 2)
      tmp << sstone[0, half].to_i
      tmp << sstone[half, sstone.length].to_i
    end

    stones = tmp
    print 'Blinked ', blinked + 1, ' times: ', stones, "\n" if debug && blinked < 6
  end

  stones.size
end

p "Test: #{star1(test_input, 25, true)} == 55312"
p "Star 1: #{star1(INPUT, 25)}"

# def star2(input, debug = false)
#   star1(input, 75)
# end
#
# p "Test: #{star2(test_input, true)} == x"
# p "Star 2: #{star2(INPUT)}"

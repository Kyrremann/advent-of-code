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

def blink(tally, blinks)
  print 'Blinked ', (blinks - 25).abs, ' times: ', tally, "\n" if blinks > 19
  return if blinks == 0

  tally.keys.each do |stone|
    next tally[1] += 1 if stone == 0

    sstone = stone.to_s
    next tally[stone * 2024] += 1 if sstone.length.odd?

    half = (sstone.length / 2)
    tally[sstone[0, half].to_i] += 1
    tally[sstone[half, sstone.length].to_i] += 1
  end

  blink(tally, blinks - 1)
end

def blink2(old_tally, blinks)
  return old_tally if blinks == 0

  tally = Hash.new(0)

  old_tally.each do |stone, n|
    next tally[1] += n if stone == 0

    sstone = stone.to_s
    next tally[stone * 2024] += n if sstone.length.odd?

    half = (sstone.length / 2)
    tally[sstone[0, half].to_i] += n
    tally[sstone[half, sstone.length].to_i] += n
  end

  blink2(tally, blinks - 1)
end

def star2(input, blinks, debug = false)
  tally = Hash.new(0)
  input.split.each { |stone| tally[stone.to_i] = 1 }
  tally = blink2(tally, blinks)

  tally.values.sum
end

p "Test: #{star2(test_input, 25, true)} == 55312"
p "Star 2: #{star2(INPUT, 75)}"

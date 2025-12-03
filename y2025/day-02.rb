#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124'

def star1(input, debug: false)
  invalids = []

  input.chomp.split(',').each do |range|
    p range if debug
    a, b = range.split('-')
    invalids << (a..b).select do |i|
      next true if i.start_with?('0')

      next if i.size.odd?

      first = i[0...(i.size / 2)]
      last = i[(i.size / 2)..i.size]
      first == last
    end
  end

  invalids.flatten!.map!(&:to_i)
  p invalids if debug
  invalids.sum
end

p "Test: #{star1(test_input, debug: false)} == 1227775554"
p "Star 1: #{star1(INPUT)}"

# def star2(input, debug: false)
# end

# p "Test: #{star2(test_input, debug: true)} == 4174379265"
# p "Star 2: #{star2(INPUT)}"

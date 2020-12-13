#!/usr/bin/env ruby

INPUT = []

File.readlines('input/day-13.txt').each do |line|
  INPUT << line.chomp
end
INPUT[0] = INPUT.first.to_i
INPUT[1] = INPUT.last.split(',').map{|n| n!='x' ? n.to_i : n}

TEST_INPUT = [
  [[7, 13, 59, 31, 19], 939],
  [[17, 'x', 13, 19], 3417],
  [[67, 7, 59, 61], 754018],
  [[67, 'x', 7, 59, 61], 779210],
  [[67, 7,'x', 59, 61], 1261476],
  [[1789, 37, 47, 1889], 1202161486]
]

def bus_calculator(timestamp, input)
  bus = input.map{|i| t=i; while t < timestamp do; t+=i; end; [i, t]}.min{|a,b| a[1]<=>b[1]}
  departing_in = bus[1] - timestamp
  departing_in * bus[0]
end

def star_1
  p "Magic test number is 295: #{bus_calculator(TEST_INPUT.first.last, TEST_INPUT.first.first) == 295}"
  input = INPUT.last.select{|n| n!='x'}
  p "Magic test number is: #{bus_calculator(INPUT.first, input)}"
end

def star_2
end

star_1
star_2

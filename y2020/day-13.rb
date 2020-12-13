#!/usr/bin/env ruby

INPUT = []

File.readlines('input/day-13.txt').each do |line|
  INPUT << line.chomp
end
INPUT[0] = INPUT.first.to_i

TEST_INPUT = [939, [7, 13, 59, 31, 19]]

def bus_calculator(timestamp, input)
  bus = input.map{|i| t=i; while t < timestamp do; t+=i; end; [i, t]}.min{|a,b| a[1]<=>b[1]}
  departing_in = bus[1] - timestamp
  departing_in * bus[0]
end

def star_1
  p "Magic test number is 295: #{bus_calculator(TEST_INPUT.first, TEST_INPUT.last) == 295}"
  input = INPUT.last.split(',').select{|n| n!='x'}.map{|n|n.to_i}
  p "Magic test number is: #{bus_calculator(INPUT.first, input)}"
end

def star_2
end

star_1
star_2

#!/usr/bin/env ruby

INPUT = []
File.readlines('input/day-09.txt').each do |line|
  INPUT << line.chomp.to_i
end

TEST_INPUT = %w(35 20 15 25 47 40 62 55 65 95 102 117 150 182 127 219 299 277 309 576).map{|s|s.to_i}

def check_valid(input, value)
  combo = input.combination(2).to_a
  return combo.select {|n| n.sum == value }.any?
end

def xmas_parser(input, preample)
  input.each_with_index do |v,i|
    next if i < preample
    return v unless check_valid(input[i - preample, preample], v)
  end
end

def star_1
  p "Is the test working: #{xmas_parser(TEST_INPUT, 5) == 127}"
  p "#{xmas_parser(INPUT, 25)} is the invalid number"
end

def group_checker(input, value, size)
  (0..input.length).each do |i|
    group = input[i, size]
    return group if input[i, size].sum == value
  end
  []
end

def encryption_weakness(input, invalid)
  (2..20).each do |n|
    output = group_checker(input, invalid, n)
    if output.any?
      output.sort!
      return output.first + output.last
    end
  end    
end

def star_2
  p "Is the test working: #{encryption_weakness(TEST_INPUT, 127) == 62}"
  p "#{encryption_weakness(INPUT, 1309761972)} is the encryption weakness"
end

star_1
star_2

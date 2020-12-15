#!/usr/bin/env ruby

INPUT = [0,20,7,16,1,18,15]
TEST_INPUT = [
  [[0,3,6], 436],
  [[1,3,2], 1],
  [[2,1,3], 10],
  [[1,2,3], 27],
  [[2,3,1], 78],
  [[3,2,1], 438],
  [[3,1,2], 1836]
]

def spoken(numbers, th)
  return numbers.last if numbers.length == th
  spk = numbers.last
  return spoken(numbers << 0, th) if numbers.count(spk) == 1
  spoken(numbers << numbers.each_index.select{|i| numbers[i] == spk}[-2..-1].reverse.inject(:-), th)
end

def star_1
  TEST_INPUT.each do |starting_numbers, answer|
    p "The 2020th number is #{answer}: #{spoken(starting_numbers.dup, 2020) == answer}"
  end
  p "The 2020th number is #{spoken(INPUT.dup, 2020)}"
end

def star_2
end

star_1
star_2

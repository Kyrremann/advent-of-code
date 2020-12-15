#!/usr/bin/env ruby

INPUT = [0,20,7,16,1,18,15]
TEST_INPUT = [
  [[0,3,6], 436, 175594],
  [[1,3,2], 1, 2578],
  [[2,1,3], 10, 3544142],
  [[1,2,3], 27, 261214],
  [[2,3,1], 78, 6895259],
  [[3,2,1], 438, 18],
  [[3,1,2], 1836, 362]
]

def recursive(numbers, th)
  return numbers.last if numbers.length == th
  spk = numbers.last
  return recursive(numbers << 0, th) if numbers.count(spk) == 1
  recursive(numbers << numbers.each_index.select{|i| numbers[i] == spk}[-2..-1].reverse.inject(:-), th)
end

def star_1
  TEST_INPUT.each do |starting_numbers, small_answer, big_answer|
    p "The 2020th number is #{small_answer}: #{recursive(starting_numbers.dup, 2020) == small_answer}"
  end
  p "The 2020th number is #{recursive(INPUT.dup, 2020)}"
end

def star_2
end

star_1
star_2

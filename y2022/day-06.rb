#!/usr/bin/env ruby

inputFile = "input/#{File.basename(__FILE__).split('.').first}.txt"

if File.exists?(inputFile)
  INPUT = File.read(inputFile)
end

testInput = {
  'mjqjpqmgbljsphdztnvjfqwrcgsmlb' => 7,
  'bvwbjplbgvbhsrlpgdmjqwftvncz' => 5,
  'nppdvjthqldpwncqszvftbrmjlhg' => 6,
  'nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg' => 10,
  'zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw' => 11
}

def start_of_marker(input, chars)
  counter = 0
  buffer = []
  input.chars.each do |c|
    counter += 1
    buffer << c
    if buffer.uniq.length == buffer.length
      return counter if buffer.length == chars
      next
    end
    buffer.shift
  end
end

def star_1(input)
  start_of_marker(input, 4)
end

testInput.each do |input, answer|
  p "Test: #{star_1(input)} == #{answer}"
end

print "Star 1: "
p star_1(INPUT) if INPUT

testInput = {
  'mjqjpqmgbljsphdztnvjfqwrcgsmlb' => 19,
  'bvwbjplbgvbhsrlpgdmjqwftvncz' => 23,
  'nppdvjthqldpwncqszvftbrmjlhg' => 23,
  'nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg' => 29,
  'zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw' => 26
}

def star_2(input)
  start_of_marker(input, 14)
end

testInput.each do |input, answer|
  p "Test: #{star_2(input)} == #{answer}"
end

print "Star 2: "
p star_2(INPUT)

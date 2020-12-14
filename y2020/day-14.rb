#!/usr/bin/env ruby

INPUT = []
index = -1
File.read('input/day-14.txt').lines(chomp: true).each do |line|
  if line.start_with?("mask")
    index += 1
    mask = line.split(' = ').last
    INPUT[index] = [mask, {}]
  else
    m = line.match(/mem\[(\d+)\] = (\d+)/)
    INPUT[index][1][m[1].to_i] = m[2].to_i
  end
end

TEST_INPUT = [
  ['XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X', {7 => 101, 8 => 0}],
  ['000000000000000000000000000000X1001X', {42 => 100}],
  ['00000000000000000000000000000000X0XX', {26 => 1}]
]

def bitmask(mask, memory)
  memory.transform_values! {|v| v.to_s(2).rjust(mask.length, '0').chars.map.with_index {|s,i| mask[i] == 'X' ? s : mask[i]}.join.to_i(2)}
end

def bitmasker(input)
  bitmasked = input.map do |blob|
    bitmask(blob.first, blob.last)
  end

  memory = {}
  bitmasked.each do |bits|
    bits.each do |k,v|
      memory[k] = v
    end
  end
  memory
end

def sum_memory(input)
  bitmasker(input).sum{|_,v| v}
end

def star_1
  p "This is test should sum to 216: #{sum_memory(TEST_INPUT) == 216}"
  p "The sum of memory is #{sum_memory(INPUT)}"
end

def star_2
end

star_1
star_2

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

def bitmask(mask, memory)
  memory.transform_values {|v| v.to_s(2).rjust(mask.length, '0').chars.map.with_index {|s,i| mask[i] == 'X' ? s : mask[i]}.join.to_i(2)}
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
  memory.sum{|_,v| v}
end

def star_1
  p "This test should sum to 216: #{bitmask('XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X', {7 => 101, 8 => 0}).sum{|_,v| v} == 165}"
  p "The sum of memory is #{bitmasker(INPUT)}"
end

def mask(addresses)
  addresses.map! {|p,v| p.sub('X', v.to_s)}
  return addresses unless addresses.join.include?('X')
  mask(addresses.product([0,1]).to_a)
end

def masker(input)
  memory = {}
  input.each do |blob|
    mask = blob.first
    blob.last.each do |address, value|
      address = address.to_s(2).rjust(mask.length, '0').chars.map.with_index {|b,i| mask[i].to_i == 1 ? 1 : mask[i] == 'X' ? 'X' : b}.join
      mask([address].product([0,1]).to_a).each do |address|
        memory[address.to_i(2)] = value
      end
    end
  end
  memory
end

def star_2
  test_input = [ ['000000000000000000000000000000X1001X', {42 => 100}], ['00000000000000000000000000000000X0XX', {26 => 1}] ]
  p "This test should sum to 208: #{masker(test_input).sum {|_,v| v} == 208}"
  p "The sum of memory is #{masker(INPUT).sum {|_,v| v}}"
end

star_1
star_2

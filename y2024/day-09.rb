#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '2333133121414131402'

def defragment(filesystem, debug)
  def find_last(index, str)
    index.downto(0).each do |i|
      next if str[i] == '.'

      return i
    end
  end

  last_index = filesystem.length - 1
  dots = filesystem.count('.')
  filesystem.each_with_index do |char, index|
    next unless char == '.'
    break if filesystem.length - index <= dots

    last_index = find_last(last_index, filesystem)

    filesystem[index] = filesystem[last_index]
    filesystem[last_index] = '.'

    p filesystem.join if debug
  end

  filesystem
end

def star1(input, debug = false)
  p input if debug
  filesystem = []
  input.chars.map(&:to_i).each_slice(2).each_with_index do |format, id|
    blocks, free = format
    blocks.times { |_| filesystem << id.to_s }
    free.times { |_| filesystem << '.' } if free
  end
  p filesystem.join if debug

  defragment(filesystem, debug).each_with_index.sum { |v, i| v.to_i * i }
end

p "Test: #{star1(test_input, true)} == 1928"
p "Star 1: #{star1(INPUT)}"

def defragment(fs, debug)
  def find(fs, length, max)
    needle = 0
    count = 0
    fs.each_with_index do |v, i|
      return false if i >= max
      next count = 0 if v != '.'

      needle = i if count == 0
      count += 1

      return needle if count >= length
    end

    false
  end

  tmp = []
  (fs.size - 1).downto(0) do |index|
    next if fs[index] == '.'

    tmp << fs[index]

    next unless fs[index - 1] != tmp[0]

    needle = find(fs, tmp.length, index)
    next tmp = [] unless needle

    tmp.each_with_index do |v, i|
      fs[needle + i] = v
      fs[index + i] = '.'
    end
    tmp = []
    p fs.join if debug
  end

  fs
end

def star2(input, debug = false)
  star1(input, debug)
end

p "Test: #{star2(test_input, true)} == 2858"
p "Star 2: #{star2(INPUT)}"

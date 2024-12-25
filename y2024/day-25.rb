#!/Usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '#####
.####
.####
.####
.#.#.
.#...
.....

#####
##.##
.#.##
...##
...#.
...#.
.....

.....
#....
#....
#...#
#.#.#
#.###
#####

.....
.....
#.#..
###..
###.#
###.#
#####

.....
.....
.....
#....
#.#..
#.#.#
#####'

def count(pins, debug = false)
  puts pins if debug
  heights = Array.new(5, -1)
  (0...5).each do |x|
    (0...7).each do |y|
      heights[x] += 1 if pins[y][x] == '#'
    end
  end

  p heights if debug
  heights
end

def format(input, debug = false)
  locks = []
  keys = []
  input.split("\n\n").map do |pins|
    pins = pins.split("\n")
    heights = count(pins, debug)
    next locks << heights if pins[0] === ('#####')

    keys << heights
  end
  [locks, keys]
end

def overlap(key, lock)
  (0...5).each { |i| return true if key[i] + lock[i] > 5 }
  false
end

def star1(input, debug = false)
  locks, keys = format(input, debug)

  p locks if debug
  p keys if debug

  overlaps = []
  keys.each do |key|
    locks.each do |lock|
      overlaps << [key, lock] unless overlap(key, lock)
    end
  end

  p overlaps if debug
  overlaps.count
end

p "Test: #{star1(test_input, true)} == 3"
p "Star 1: #{star1(INPUT)}"

# def star2(input, debug = false)
# end

# p "Test: #{star2(test_input, true)} == 23"
# p "Star 2: #{star2(INPUT)}"

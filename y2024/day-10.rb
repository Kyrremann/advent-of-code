#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732'

def walk(map, y, x, prev, uniq = true, debug = false)
  current = map[y][x].to_i
  return [] if current != prev + 1

  print 'found: ', [y, x], "\n" if debug && current == (9)
  return [[y, x]] if current == 9

  trailheads = []
  trailheads.concat walk(map, y - 1, x, current, uniq, debug) if y - 1 >= 0
  trailheads.concat walk(map, y, x + 1, current, uniq, debug) if x + 1 < map[y].length
  trailheads.concat walk(map, y + 1, x, current, uniq, debug) if y + 1 < map.length
  trailheads.concat walk(map, y, x - 1, current, uniq, debug) if x - 1 >= 0

  uniq ? trailheads.uniq : trailheads
end

def star1(input, uniq = true, debug = false)
  input = input.split("\n")

  trailheads = Hash.new(0)

  (0...input.length).each do |y|
    (0...input[y].length).each do |x|
      next if input[y][x] != '0'

      print [y, x], ': starting', "\n" if debug
      trailheads[[y, x]] += walk(input, y, x, -1, uniq, debug).count
    end
  end

  p trailheads if debug
  p trailheads.values.sum
end

p "Test: #{star1(test_input, true, true)} == 36"
p "Star 1: #{star1(INPUT)}"

def star2(input, debug = false)
  star1(input, false, debug)
end
p "Test: #{star2(test_input, true)} == 81"
p "Star 2: #{star2(INPUT, true)}"

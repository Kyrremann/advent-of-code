#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).split('.').first}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = 'seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4'

class Ranger
  attr_accessor :dest_start, :dest_end, :src_start, :src_end, :range

  def initialize(dest, src, range)
    @dest_start = dest
    @dest_end = dest + range - 1
    @src_start = src
    @src_end = src + range - 1
    @range = range
  end

  def src_to_dest(src)
    return nil unless src >= @src_start && src <= @src_end

    dest_start + (src - @src_start)
  end

  def to_s
    "dest: #{@dest_start}-#{@dest_end}, src: #{@src_start}-#{@src_end}, range: #{@range}"
  end

  def inspect
    to_s
  end
end

def create_map(input, map, label)
  label = label.sub('map', '').strip
  map[label] ||= []
  tmp = input.split("\n").map { |x| x.split(' ').map(&:to_i) }
  tmp.each do |row|
    dest, src, range = row
    map[label] << Ranger.new(dest, src, range)
  end
end

def parse_input(input)
  seeds = []
  map = {}
  input.split(/\n\n/).map do |section|
    label, numbers = section.split(':')
    numbers = numbers.strip
    if label == 'seeds'
      seeds = numbers.split.map(&:to_i)
    else
      create_map(numbers, map, label)
    end
  end

  [seeds, map]
end

def find_location(map, seed)
  debug = false
  print "seed #{seed}, " if debug
  needle = seed
  map.each do |label, rangers|
    next if label == 'seeds'

    rangers.each do |ranger|
      next_needle = ranger.src_to_dest(needle)
      if next_needle
        needle = next_needle
        break
      end
    end
    print "#{label.split('-').last} #{needle}, " if debug
  end
  p "location #{needle}" if debug
  needle
end

def star1(input)
  seeds, map = parse_input(input)
  seeds.map do |seed|
    find_location(map, seed)
  end.min
end

p "Test: #{star1(test_input)} == 35"

print 'Star 1: '
p star1(INPUT)

def star2(input)
  tmp, map = parse_input(input)
  seeds = []
  (0..tmp.length).step(2).each do |i|
    break if i >= tmp.length

    (tmp[i]..(tmp[i] + tmp[i + 1])).each do |seed|
      seeds << seed
    end
  end

  seeds.map do |seed|
    find_location(map, seed)
  end.min
end

p "Test: #{star2(test_input)} == 46"

print 'Star 2: '
p star2(INPUT)

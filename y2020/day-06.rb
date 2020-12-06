#!/usr/bin/env ruby

INPUT = []
File.readlines('input/day-06.txt').each do |line|
  INPUT << line.chomp
end

def star_1
  p INPUT.join('-').split('--').sum {|g| g.gsub('-', '').chars.sort.uniq.join.length}
end

def star_2
end

star_1
star_2

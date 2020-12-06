#!/usr/bin/env ruby

INPUT = []
File.readlines('input/day-06.txt').each do |line|
  INPUT << line.chomp
end

def star_1
  p INPUT.join('-').split('--').sum {|g| g.gsub('-', '').chars.uniq.count}
end

def star_2
  p INPUT.join('-').split('--').sum {|g| g.gsub('-', '').chars.group_by(&:itself).count {|_,l| l.count >= g.split('-').length}}
end

star_1
star_2

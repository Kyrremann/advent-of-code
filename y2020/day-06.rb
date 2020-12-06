#!/usr/bin/env ruby

INPUT = []
File.readlines('input/day-06.txt').each do |line|
  INPUT << line.chomp
end

def star_1
  p INPUT.join('-').split('--').sum {|g| g.gsub('-', '').chars.sort.uniq.join.length}
end

def star_2
  p INPUT.join('-').split('--').sum {|g|
    group_size = g.split('-').length
    group_answers = g.gsub('-', '')
    group_answers.chars.group_by(&:itself).map {|letter, list| [letter, list.count]}.select{|g| g[1] >= group_size}.count
  }
end

star_1
star_2

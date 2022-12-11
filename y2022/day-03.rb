#!/usr/bin/env ruby

inputFile = "input/#{File.basename(__FILE__).split('.').first}.txt"

if File.exists?(inputFile)
  INPUT = File.read(inputFile)
end

testInput = '''vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw'''

def star_1(input)
  input.split.sum do |line|
    x = line.slice!(0, line.length/2).chars
    y = line.chars
    ['', *('a'..'z'), *('A'..'Z')].index(x.intersection(y).join)
  end
end

p "Test: #{star_1(testInput)} == 157"

print "Star 1: "
p star_1(INPUT) if INPUT

def star_2(input)
  input.split.each_slice(3).sum do |slices|
    a, b, c = slices.map(&:chars)
    ['', *('a'..'z'), *('A'..'Z')].index(a.intersection(b, c).join)
  end
end

p "Test: #{star_2(testInput)} == 70"

print "Star 2: "
p star_2(INPUT)

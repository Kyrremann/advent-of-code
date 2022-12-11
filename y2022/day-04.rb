#!/usr/bin/env ruby

inputFile = "input/#{File.basename(__FILE__).split('.').first}.txt"

if File.exists?(inputFile)
  INPUT = File.read(inputFile)
end

testInput = '''2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8'''

def complete_overlap?(a,b, x,y)
  (a >= x && a <= y && b >= x && b <= y) || (x >= a && x <= b && y >= a && y <= b)
end

def star_1(input)
  input.split.select{ |pairs|
    complete_overlap?(*pairs.split(',').map{ |pair|
                   pair.split('-')}.flatten.map(&:to_i)) }.size
end

p "Test: #{star_1(testInput)} == 2"

print "Star 1: "
p star_1(INPUT) if INPUT

def overlap?(a,b, x,y)
  x <= b && a <= y
end

def star_2(input)
  input.split.select{ |pairs|
    overlap?(*pairs.split(',').map{ |pair|
                   pair.split('-')}.flatten.map(&:to_i)) }.size
end

p "Test: #{star_2(testInput)} == 4"

print "Star 2: "
p star_2(INPUT)

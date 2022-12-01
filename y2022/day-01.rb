#!/usr/bin/env ruby

inputFile = "input/#{File.basename(__FILE__).split('.').first}.txt"

if File.exists?(inputFile)
  INPUT = File.read(inputFile)
end

testInput = '''1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
'''

def star_1(input)
  input.split(/\n\n/).map { |x| x.split(/\n/).map(&:to_i).sum }.max
end

p "Test: #{star_1(testInput)} == 24000"

print "Star 1: "
p star_1(INPUT)

def star_2(input)
  input.split(/\n\n/).map { |x| x.split(/\n/).map(&:to_i).sum }.sort.reverse.first(3).sum
end

p "Test: #{star_2(testInput)} == 45000"

print "Star 2: "
p star_2(INPUT)

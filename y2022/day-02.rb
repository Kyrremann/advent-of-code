#!/usr/bin/env ruby

inputFile = "input/#{File.basename(__FILE__).split('.').first}.txt"

if File.exists?(inputFile)
  INPUT = File.read(inputFile)
end

testInput = '''A Y
B X
C Z
'''

#  A == rock
#  B == paper
#  C == scissors
#
#  X == rock
#  Y == paper
#  Z == scissors
def simple_rock_paper_scissors(input)
  case input
  when "A X"
    return 1+3
  when "A Y"
    return 2+6
  when "A Z"
    return 3
  when "B X"
    return 1
  when "B Y"
    return 2+3
  when "B Z"
    return 3+6
  when "C X"
    return 1+6
  when "C Y"
    return 2
  when "C Z"
    return 3+3
  end
end

def star_1(input)
  input.split(/\n/).map { |x| simple_rock_paper_scissors(x) }.sum
end

p "Test: #{star_1(testInput)} == 15"

print "Star 1: "
p star_1(INPUT) if INPUT

#  A == rock
#  B == paper
#  C == scissors
#
#  X == lose
#  Y == draw
#  Z == win
def rock_paper_scissors(round)
  hand, guide = round.split
  index = ['', 'A', 'B', 'C'].index(hand)
  case guide
  when 'X'
    return index == 1 ? 3 : index - 1
  when 'Y'
    return index + 3
  when 'Z'
    return (index == 3 ? 1 : index + 1) + 6
  end
end

def star_2(input)
  input.split(/\n/).map { |x| rock_paper_scissors(x) }.sum
end

p "Test: #{star_2(testInput)} == 12"

print "Star 2: "
p star_2(INPUT)

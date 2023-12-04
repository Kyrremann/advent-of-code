#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).split('.').first}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet'

def find_first_and_last_int(input)
  first = input.chars.find { |x| x =~ /[0-9]/ }
  last = input.chars.reverse.find { |x| x =~ /[0-9]/ }
  # puts "#{input} => #{first} #{last}"
  [first, last].join.to_i
end

def star1(input)
  input.split(/\n/).sum { |x| find_first_and_last_int(x) }
end

p "Test: #{star1(test_input)} == 142"

print 'Star 1: '
p star1(INPUT)

def word_to_int(word)
  return word if word =~ /[0-9]/

  %w[zero one two three four five six seven eight nine].find_index(word)
end

def find_first_and_last_int_better(input)
  first = input[/(one|two|three|four|five|six|seven|eight|nine|[0-9])/]
  last = input.reverse[/(enin|thgie|neves|xis|evif|ruof|eerht|owt|eno|[0-9])/].reverse
  # puts "#{input} => #{first} #{last}"
  first = word_to_int(first)
  last = word_to_int(last)
  [first, last].join.to_i
end

test_input = 'two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen'

def star2(input)
  input.split(/\n/).sum { |x| find_first_and_last_int_better(x) }
end

p "Test: #{star2(test_input)} == 281"

print 'Star 2: '
p star2(INPUT)

#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).split('.').first}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = 'Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green'

def star1(input, rules)
  sum = 0
  input.split(/\n/).each_with_index do |game, index|
    sum += index + 1 if game.split(': ').last.split('; ').all? do |round|
      round.split(', ').select do |set|
        count, color = set.split(' ')
        rules[color] < count.to_i
      end.empty?
    end
  end

  sum
end

rules = { 'red' => 12, 'green' => 13, 'blue' => 14 }
p "Test: #{star1(test_input, rules)} == 8"

print 'Star 1: '
p star1(INPUT, rules)

def star2(input)
  input.split(/\n/).sum do |game|
    sets = {}
    game.split(': ').last.split('; ').all? do |round|
      round.split(', ').each do |set|
        count, color = set.split(' ')
        sets[color] ||= -1
        sets[color] = count.to_i if sets[color] < count.to_i
      end
    end
    sets.values.inject(:*)
  end
end

p "Test: #{star2(test_input)} == 2286"

print 'Star 2: '
p star2(INPUT)

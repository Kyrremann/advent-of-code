#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47'

def format(input)
  rules, updates = input.split("\n\n")
  [rules.split("\n").map { |v| v.split('|') }, updates.split("\n")]
end

def star1(input)
  rules, updates = format(input)
  updates.select do |update|
    rules.all? do |rule|
      break false if update.match(/#{rule[1]}.*#{rule[0]}/)

      true
    end
  end.sum do |update|
    u = update.split(',')
    u[u.length / 2].to_i
  end
end

p "Test: #{star1(test_input)} == 143"
p "Star 1: #{star1(INPUT)}"

def star2(input)
  def ordering(update, rules)
    rules.each do |rule|
      a = rule[0]
      b = rule[1]
      next unless update.match(/#{b}.*#{a}/)

      u = update.split(',')
      ai = u.index(a)
      bi = u.index(b)
      u.delete_at(bi)
      u = u.insert(ai, b)
      update = u.join(',')

      update = ordering(update, rules)
      break
    end

    update
  end

  rules, updates = format(input)
  updates.select do |update|
    rules.any? do |rule|
      update.match(/#{rule[1]}.*#{rule[0]}/)
    end
  end.map do |update|
    ordering(update, rules)
  end.sum do |update|
    u = update.split(',')
    u[u.length / 2].to_i
  end
end

p "Test: #{star2(test_input)} == 123"
p "Star 2: #{star2(INPUT)}"

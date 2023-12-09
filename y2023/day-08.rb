#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).split('.').first}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input_1 = 'RL

AAA = (BBB, CCC)
BBB = (DDD, EEE)
CCC = (ZZZ, GGG)
DDD = (DDD, DDD)
EEE = (EEE, EEE)
GGG = (GGG, GGG)
ZZZ = (ZZZ, ZZZ)'

test_input_2 = 'LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)'

class Node
  attr_accessor :name, :left, :right

  def initialize(data)
    data.gsub!(/\(|\)/, '')
    @name, rest = data.split(' = ')
    @left, @right = rest.split(', ')
  end

  def to_s
    "#{name} = (#{left}, #{right})"
  end
end

def format_input(input)
  inst, map = input.split(/\n\n/)
  inst = inst.chars
  map = map.split(/\n/).map { |node| Node.new(node) }
  [inst, map]
end

def star1(input)
  inst, map = format_input(input)

  steps = 0
  current = 'AAA'
  index = 0
  while current != 'ZZZ'
    steps += 1
    node = map.find { |n| n.name == current }

    current = inst[index] == 'R' ? node.right : node.left
    index += 1
    index = 0 if index >= inst.length
  end

  steps
end

p "Test: #{star1(test_input_1)} == 2"
p "Test: #{star1(test_input_2)} == 6"

print 'Star 1: '
p star1(INPUT)

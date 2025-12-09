#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '162,817,812
57,618,57
906,360,560
592,479,940
352,342,300
466,668,158
542,29,236
431,825,988
739,650,466
52,470,668
216,146,977
819,987,18
117,168,530
805,96,715
346,949,466
970,615,88
941,993,340
862,61,35
984,92,344
425,690,689'

def min(hash, history)
  min_key = nil
  min = Float::INFINITY

  hash.each_pair do |key, value|
    next if value > min || history.include?(key)

    min_key = key
    min = value
  end

  [min_key, min]
end

class Node
  attr_reader :id, :edges

  def initialize(id)
    @id = id
    @edges = Set[]
  end

  def add(id)
    @edges.add(id)
  end
end

def star1(input, connections, debug: false)
  junctions = {}

  input = input.split.map { |line| line.split(',').map(&:to_i) }
  input.each do |x1, y1, z1|
    input.each do |x2, y2, z2|
      next if x1 == x2 && y1 == y2 && z1 == z2

      key1 = [x1, y1, z1].join(',')
      key2 = [x2, y2, z2].join(',')

      next if junctions["#{key1}-#{key2}"] || junctions["#{key2}-#{key1}"]

      junctions["#{key1}-#{key2}"] = Math.sqrt((x1 - x2)**2 + (y1 - y2)**2 + (z1 - z2)**2)
    end
  end

  history = {}
  connections.times do |_|
    key, value = min(junctions, history)
    history[key] = value
  end

  edges = {}
  history.each do |key, value|
    p "#{key}: #{value}" if debug

    key1, key2 = key.split('-')

    node1 = edges[key1]
    unless node1
      node1 = Node.new(key1)
      edges[key1] = node1
    end

    node2 = edges[key2]
    unless node2
      node2 = Node.new(key2)
      edges[key2] = node2
    end

    node1.add(node2)
    node2.add(node1)
  end

  collect = lambda do |circuit, edges|
    edges.each do |edge|
      next unless circuit.add?(edge.id)

      collect.call(circuit, edge.edges)
    end
  end

  circuits = []
  edges.each do |id, node|
    next if circuits.any? { |circuit| circuit.include?(id) }

    circuit = Set[]
    circuit.add(id)
    collect.call(circuit, node.edges)

    p circuit if debug
    circuits << circuit
  end

  circuits.map(&:size).sort[-3..].reduce(:*)
end

p "Test: #{star1(test_input, 10, debug: true)} == 40"
p "Star 1: #{star1(INPUT, 1000)}"

# def star2(input, debug = false)
# end
#
# p "Test: #{star2(test_input, true)} == x"
# p "Star 2: #{star2(INPUT)}"

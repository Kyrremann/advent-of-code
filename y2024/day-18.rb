#!/usr/bin/env ruby
# frozen_string_literal: true

require 'dijkstra_trace'

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '5,4
4,2
4,5
3,0
2,1
6,3
2,4
1,5
0,6
3,3
2,6
5,1
1,2
5,5
2,5
6,5
1,4
0,4
6,4
1,1
6,1
1,0
0,5
1,6
2,0'

def format(input, size, bytes, debug = false)
  all_locations = input.split("\n").map { |line| line.split(',').map(&:to_i) }
  locations = all_locations[0, bytes]
  edges = []

  is_safe = ->(x, y) { !locations.include?([x, y]) }

  (0...size).each do |y|
    (0...size).each do |x|
      next unless is_safe.call(x, y)

      edges << [[x, y], [x, y - 1], 1] if y > 0 && is_safe.call(x, y - 1)
      edges << [[x, y], [x, y + 1], 1] if y < size && is_safe.call(x, y + 1)
      edges << [[x, y], [x - 1, y], 1] if x > 0 && is_safe.call(x - 1, y)
      edges << [[x, y], [x + 1, y], 1] if x < size && is_safe.call(x + 1, y)
    end
  end

  p all_locations.index([36, 17])

  [edges.sort, all_locations[bytes..-1]]
end

def star1(input, size, bytes, debug = false)
  edges, = format(input, size, bytes, debug)
  graph = Dijkstra::Trace.new(edges)
  path = graph.path([0, 0], [size - 1, size - 1])

  if debug
    puts "The shortest distance between #{path.starting_point} and #{path.ending_point} is #{path.distance} units"
    puts "The shortest path: #{path.path}"
  end

  path.distance
end

p "Test: #{star1(test_input, 7, 12, true)} == 22"
# p "Star 1: #{star1(INPUT, 71, 1024)}"

def star2(input, size, bytes, debug = false)
  edges, leftovers = format(input, size, bytes, debug)
  p leftovers if debug

  graph = Dijkstra::Trace.new(edges)
  path = graph.path([0, 0], [size - 1, size - 1])

  leftovers.each do |byte|
    edges.reject! { |edge| edge.include?(byte) }

    next unless path.path.include?(byte)

    p "Building ny graph, #{byte} is blocking"

    graph = Dijkstra::Trace.new(edges)
    path = graph.path([0, 0], [size - 1, size - 1])

    return byte if path.distance == 9_999_999
  end
end

p "Test: #{star2(test_input, 7, 12, true)} == [6, 1]"
p "Star 2: #{star2(INPUT, 71, 1024)}"

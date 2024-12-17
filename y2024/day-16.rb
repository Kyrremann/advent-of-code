#!/usr/bin/env ruby
# frozen_string_literal: true

require 'dijkstra_trace'

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '###############
#.......#....E#
#.#.###.#.###.#
#.....#.#...#.#
#.###.#####.#.#
#.#.#.......#.#
#.#.#####.###.#
#...........#.#
###.#.#####.#.#
#...#.....#.#.#
#.#.#.###.#.#.#
#.....#...#.#.#
#.###.#.#.#.#.#
#S..#.....#...#
###############'

def format(input, debug = false)
  # edge(from, to, weight)
  edges = []
  input = input.split("\n")
  start = []
  stop = []

  (0...input.length).each do |y|
    (0...input[y].length).each do |x|
      tile = input[y][x]
      next if tile == '#'
      next start = [y, x] if tile == 'S'
      next stop = [y, x] if tile == 'E'

      edges << [[y, x], [y - 1, x], 1] if y > 0 && ['.', 'E', 'S'].include?(input[y - 1][x])
      edges << [[y, x], [y + 1, x], 1] if y < input.length && ['.', 'E', 'S'].include?(input[y + 1][x])
      edges << [[y, x], [y, x - 1], 1] if x > 0 && ['.', 'E', 'S'].include?(input[y][x - 1])
      edges << [[y, x], [y, x + 1], 1] if x < input[y].length && ['.', 'E', 'S'].include?(input[y][x + 1])
    end
  end

  p [edges.sort, start, stop]
end

def star1(input, debug = false)
  edges, start, stop = format(input, debug)
  graph = Dijkstra::Trace.new(edges)
  path = graph.path(start, stop)

  puts "The shortest distance between #{path.starting_point} and #{path.ending_point} is #{path.distance} units"
  puts "The shortest path: #{path.path}"

  dir = 'E'
  score = 0
  path.path.each_cons(2) do |from, to|
    y, x = from
    yy, xx = to

    diffx = x - xx
    diffy = y - yy
    ndir = if diffx == 0
             if diffy > 0
               'N'
             else
               'S'
             end
           elsif diffx > 0
             'W'
           else
             'E'
           end

    next score += 1 if dir == ndir
    next score += 1000 if dir == 'E' && %w[N S].include?(ndir)
    next score += 1000 if dir == 'S' && %w[E W].include?(ndir)
    next score += 1000 if dir == 'W' && %w[N S].include?(ndir)
    next score += 1000 if dir == 'N' && %w[W E].include?(ndir)
    next score += 2000 if dir == 'E' && ndir == 'W'
    next score += 2000 if dir == 'S' && ndir == 'N'
    next score += 2000 if dir == 'W' && ndir == 'E'
    next score += 2000 if dir == 'N' && ndir == 'S'
  end

  score
end

p "Test: #{star1(test_input, true)} == 7036"
# p "Star 1: #{star1(INPUT)}"

# def star2(input, debug = false)
# end
#
# p "Test: #{star2(test_input, true)} == x"
# p "Star 2: #{star2(INPUT)}"

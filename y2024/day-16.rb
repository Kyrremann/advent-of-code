#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'

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

test_input_2 = '#################
#...#...#...#..E#
#.#.#.#.#.#.#.#.#
#.#.#.#...#...#.#
#.#.#.#.###.#.#.#
#...#.#.#.....#.#
#.#.#.#.#.#####.#
#.#...#.#.#.....#
#.#.#####.#.###.#
#.#.#.......#...#
#.#.###.#####.###
#.#.#...#.....#.#
#.#.#.#####.###.#
#.#.#.........#.#
#.#.#.#########.#
#S#.............#
#################'

def format(input, debug = false)
  input = input.split("\n")
  nodes = []
  source = []
  target = []

  (0...input.length).each do |y|
    (0...input[y].length).each do |x|
      tile = input[y][x]
      next if tile == '#'

      source = [y, x] if tile == 'S'
      target = [y, x] if tile == 'E'

      nodes << [y, x]
    end
  end

  [nodes, source, target]
end

def calculate_distance(nodes, source, target)
  def weight(prev, a, b)
    prev ||= [a.first, a.last - 1]
    py = prev.first - a.first
    px = prev.last - a.last

    y = a.first - b.first
    x = a.last - b.last

    return 1 if [py, px] == [y, x]

    1001
  end

  def get_neighbors(queue, c)
    y, x = c
    [
      [y + 1, x],
      [y - 1, x],
      [y, x + 1],
      [y, x - 1]
    ].select { |ortho| queue.include?(ortho) }
  end

  def shortest_distance(queue, distances)
    shortest = Float::INFINITY
    min = nil

    queue.each do |k|
      distance = distances[k]
      if distance < shortest
        shortest = distance
        min = k
      end
    end

    min
  end

  def get_path(current, previous, distances)
    path = []
    while current
      path << current
      current = previous[current]
    end

    weight = distances[path.first]
    [path.reverse, weight]
  end

  distances = {}
  previous = {}
  queue = []

  nodes.each do |node|
    distances[node] = Float::INFINITY
    previous[node] = nil
    queue << node
  end

  distances[source] = 0

  until queue.empty?
    current = shortest_distance(queue, distances)
    if current == target
      p 'Found it!'
      return get_path(current, previous, distances)
    end

    queue.delete(current)

    get_neighbors(queue, current).each do |neighbor|
      score = distances[current] + weight(previous[current], current, neighbor)
      if score < distances[neighbor]
        distances[neighbor] = score
        previous[neighbor] = current
      end
    end
  end
end

def star1(input, debug = false)
  p Time.now

  nodes, source, target = format(input)

  p Time.now

  path, weight = calculate_distance(nodes, source, target)

  if debug
    map = input.split("\n")
    path.each { |p| map[p.first][p.last] = 'o' }
    map.each { |s| puts s }
  end

  p Time.now

  weight
end

p "Test: #{star1(test_input, true)} == 7036"
p "Test: #{star1(test_input_2, true)} == 11048"
p "Star 1: #{star1(INPUT)}"

# def star2(input, debug = false)
# end
#
# p "Test: #{star2(test_input, true)} == x"
# p "Star 2: #{star2(INPUT)}"

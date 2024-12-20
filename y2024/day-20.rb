#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '###############
#...#...#.....#
#.#.#.#.#.###.#
#S#...#.#.#...#
#######.#.#.###
#######.#.#...#
#######.#.###.#
###..E#...#...#
###.#######.###
#...###...#...#
#.#####.#.###.#
#.#...#.#.#...#
#.#.#.#.#.#.###
#...#...#...###
###############'

def find_start(input)
  (0...input.length).each do |y|
    (0...input[y].length).each do |x|
      return x, y if input[y][x] == 'S'
    end
  end
end

def race(map, dir)
  x, y = find_start(map)

  track = [[x, y]]
  directions = [[x, y - 1], [x + 1, y], [x, y + 1], [x - 1, y]]

  def find_skip(dir)
    case dir
    when 0
      2
    when 1
      3
    when 2
      0
    when 3
      1
    end
  end

  while true
    xx, yy = directions[dir]
    if map[yy][xx] == '.'
      track << [xx, yy]

      skip = find_skip(dir)
      directions = [[xx, yy - 1], [xx + 1, yy], [xx, yy + 1], [xx - 1, yy]]
      next
    elsif map[yy][xx] == 'E'
      track << [xx, yy]
      return track
    end

    dir += 1
    dir += 1 if dir == skip
    dir = 0 if dir > 3
    dir = 1 if dir == skip
  end
end

def time_to_cheat(track, debug = false)
  cheats = Hash.new(0)

  track.each_with_index do |loc, start|
    x, y = loc
    print 'Starting from ', x, ',', y, "\n" if debug

    (start...track.length).each do |index|
      xx, yy = track[index]

      next unless x + 2 == xx && y == yy ||
                  x - 2 == xx && y == yy ||
                  x == xx && y + 2 == yy ||
                  x == xx && y - 2 == yy

      p "Start[#{x},#{y}]: #{start}, end[#{xx},#{yy}]: #{index}" if debug
      saved = index - start - 2
      next if saved < 100

      cheats[saved] += 1
    end
  end

  cheats
end

def star1(input, dir, debug = false)
  map = input.split("\n")

  track = race(map, dir)
  p track if debug

  p 'Track finished, time to cheat!'
  cheats = time_to_cheat(track, debug)

  # if debug
  cheats.sort_by { |ps, cheat| ps }.each do |ps, cheat|
    p "There are #{cheat} cheats that save #{ps} picoseconds."
  end
  # end

  cheats.values.sum
end

p "Test: #{star1(test_input, 0, true)} == 44"
p "Star 1: #{star1(INPUT, 2)}"

# def star2(input, debug = false)
# end
#
# p "Test: #{star2(test_input, true)} == x"
# p "Star 2: #{star2(INPUT)}"

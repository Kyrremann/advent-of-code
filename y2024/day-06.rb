#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...'

def format(input)
  input.split("\n")
end

def star1(input)
  def find_start(map)
    map.each_with_index do |row, y|
      matchdata = row.match(/(<|>|v|\^)/)
      return matchdata[0], y, matchdata.begin(0) if matchdata
    end
  end

  def move(y, x, direction, map)
    # print y, ',', x, ': ', direction, "\n"
    map[y][x] = 'X'
    # puts map

    case direction
    when '^'
      return map if y == 0

      map[y - 1][x] == '#' ? move(y, x, '>', map) : move(y - 1, x, direction, map)
    when '>'
      return map if x == map[y].length - 1

      map[y][x + 1] == '#' ? move(y, x, 'v', map) : move(y, x + 1, direction, map)
    when 'v'
      return map if y == map.length - 1

      map[y + 1][x] == '#' ? move(y, x, '<', map) : move(y + 1, x, direction, map)
    when '<'
      return map if x == 0

      map[y][x - 1] == '#' ? move(y, x, '^', map) : move(y, x - 1, direction, map)
    end
  end

  map = format(input)
  direction, y, x = find_start(map)
  visited =  move(y, x, direction, map)
  visited.join.count('X')
end

p "Test: #{star1(test_input)} == 41"
p "Star 1: #{star1(INPUT)}"

# def star2(input)
# end
#
# p "Test: #{star2(test_input)} == x"
# p "Star 2: #{star2(INPUT)}"

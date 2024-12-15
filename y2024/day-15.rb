#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '########
#..O.O.#
##@.O..#
#...O..#
#.#.O..#
#...O..#
#......#
########

<^^>>>vv<v>>v<<'

big_input = '##########
#..O..O.O#
#......O.#
#.OO..O.O#
#..O@..O.#
#O#..O...#
#O..O..O.#
#.OO.O.OO#
#....O...#
##########

<vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^
vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v
><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<
<<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^
^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><
^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^
>^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^
<><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>
^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>
v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^'

class Tile
  attr_accessor :y, :x

  def initialize(y, x)
    @y = y
    @x = x
  end

  def to_s
    "#{@y},#{@x}"
  end
end

class Matrix
  def initialize(height, width)
    @hash = {}
    @height = height
    @width = width
  end

  def [](y, x)
    @hash[[y, x]]
  end

  def []=(y, x, val)
    @hash[[y, x]] = val
  end

  def delete(y, x)
    @hash.delete([y, x])
  end

  def draw(bot)
    (0...@height).each do |y|
      (0...@width).each do |x|
        tile = @hash[[y, x]]
        tile ||= '.'
        tile = '@' if bot.x == x && bot.y == y
        print tile
      end

      puts ''
    end
  end

  def sum
    @hash.sum do |yx, tile|
      next 0 if tile != 'O'

      y, x = yx

      100 * y + x
    end
  end
end

def format(input)
  warehouse, movements = input.split("\n\n")
  warehouse = warehouse.split("\n")

  map = Matrix.new(warehouse.length, warehouse[0].length)
  start = nil

  (0...warehouse.length).each do |y|
    (0...warehouse[y].length).each do |x|
      tile = warehouse[y][x]
      map[y, x] = tile unless ['.', '@'].include?(tile)
      start = Tile.new(y, x) if tile == '@'
    end
  end

  [map, movements.split("\n").join.reverse.chars, start]
end

def shift(map, y, x, move)
  nx = x
  ny = y
  case move
  when '^'
    ny -= 1
  when '>'
    nx += 1
  when '<'
    nx -= 1
  when 'v'
    ny += 1
  end
  tile = map[ny, nx]

  return false if tile == '#'

  return false if tile == 'O' && !shift(map, ny, nx, move)

  # print 'Moving ', y, ',', x, ' to ', y, ',', nx, "\n"
  map[ny, nx] = 'O'
  map.delete(y, x)
end

def star1(input, debug = false)
  map, movements, start = format(input)
  p movements.reverse if debug
  while move = movements.pop

    print move, ': ', start if debug

    case move
    when '^'
      ny = start.y - 1
      if map[ny, start.x] != '#'
        shift(map, ny, start.x, move) if map[ny, start.x] == 'O'
        start.y = ny unless map[ny, start.x]
      end
    when '>'
      nx = start.x + 1
      if map[start.y, nx] != '#'
        shift(map, start.y, nx, move) if map[start.y, nx] == 'O'
        start.x = nx unless map[start.y, nx]
      end
    when '<'
      nx = start.x - 1
      if map[start.y, nx] != '#'
        shift(map, start.y, nx, move) if map[start.y, nx] == 'O'
        start.x = nx unless map[start.y, nx]
      end
    when 'v'
      ny = start.y + 1
      if map[ny, start.x] != '#'
        shift(map, ny, start.x, move) if map[ny, start.x] == 'O'
        start.y = ny unless map[ny, start.x]
      end
    end

    print ' -> ', start, "\n" if debug

    puts "Move #{move}:" if debug
    map.draw(start) if debug
    puts '' if debug
  end

  map.sum
end

debug = false
p "Test: #{star1(test_input, debug)} == 2028"
p "Test: #{star1(big_input, debug)} == 10092"
p "Star 1: #{star1(INPUT)}"

# def star2(input, debug = false)
# end
#
# p "Test: #{star2(test_input, true)} == x"
# p "Star 2: #{star2(INPUT)}"

#!/usr/bin/env ruby

INPUT = File.read('input/day-11.txt').split("\n").map {|l| l.chars}

TEST_INPUT = '''L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL'''.split("\n").map {|l| l.chars}

def around(input, x, y)
  possible = []
  possible << input[y-1][x] if y > 0
  possible << input[y-1][x-1] if y > 0 && x > 0
  possible << input[y-1][x+1] if y > 0 && x < input[y].length-1

  possible << input[y][x-1] if x > 0
  possible << input[y][x+1] if x < input[y].length-1

  possible << input[y+1][x] if y < input.length-1
  possible << input[y+1][x-1] if y < input.length-1 && x > 0
  possible << input[y+1][x+1] if y < input.length-1 && x < input[y].length-1
  possible.count('#')
end

def chaos_stabilizer(input)
  changed = true
  while changed
    changed = false
    input = input.map.with_index do |row, y|
      row.map.with_index do |c, x|
        occupied = around(input, x, y)
        if c == 'L' && occupied == 0
          changed = true
          '#'
        elsif c == '#' && occupied >= 4
          changed = true
          'L'
        else
          c
        end
      end
    end
  end
  input.sum {|n| n.count('#')}
end

def star_1
  p chaos_stabilizer(TEST_INPUT) == 37
  p chaos_stabilizer(INPUT)
end

def star_2
end

star_1
star_2

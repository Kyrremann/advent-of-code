#!/usr/bin/env ruby

TREE = '#'
INPUT = []
File.readlines('input/day-03.txt').each_with_index do |line, index|
  INPUT[index] = line.chomp.chars
end

Location = Struct.new(:x, :y)

def get_location(loc)
  INPUT[loc.y][loc.x]
end

def move(loc)
  loc.x += 3
  loc.y += 1

  if loc.x >= INPUT[loc.y].length
    loc.x = loc.x - INPUT[loc.y].length
  end
end

def star_1
  trees = 0
  me = Location.new(0, 0)
  loop do
    move(me)
    p get_location(me)
    if get_location(me) == TREE
      trees += 1
    end
    break if me.y == INPUT.length - 1
  end

  p "I've seen #{trees} trees"
end

def star_2
end

star_1
star_2

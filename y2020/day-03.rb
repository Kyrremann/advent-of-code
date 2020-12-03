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

def move(loc, slope)
  loc.x += slope.x
  loc.y += slope.y

  if loc.x >= INPUT[loc.y].length
    loc.x = loc.x - INPUT[loc.y].length
  end
end

def star_1(slope)
  trees = 0
  me = Location.new(0, 0)
  loop do
    move(me, slope)
    if get_location(me) == TREE
      trees += 1
    end
    break if me.y == INPUT.length - 1
  end

  p "I've seen #{trees} trees"
  trees
end

def star_2
  trees = star_1(Location.new(1,1))
  trees *= star_1(Location.new(3,1))
  trees *= star_1(Location.new(5,1))
  trees *= star_1(Location.new(7,1))
  trees *= star_1(Location.new(1,2))
  p "All #{trees} have been seen"
end

star_1(Location.new(3, 1))
star_2

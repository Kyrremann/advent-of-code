#!/usr/bin/env ruby

INPUT = []
File.readlines('input/day-12.txt').each do |line|
  INPUT << line.chomp
end

TEST_INPUT = %w(F10 N3 F7 R90 F11)

module Movable
  def move(direction, value)
    case direction
    when 'N'
     @y += value
    when 'E'
     @x += value
    when 'S'
     @y -= value
    when 'W'
     @x -= value
    end
  end
end

class Boat
  include Movable

  def initialize(facing, x, y)
    @direction = facing
    @x = x
    @y = y
  end

  def dir_to_int(dir)
    {N: 0, E: 1, S: 2, W: 3}[dir.to_sym]
  end

  def int_to_dir(int)
    int -= 4 if int > 3
    int += 4 if int < 0
    ['N', 'E', 'S', 'W'][int]
  end

  def direction(input)
    action, value = [input[0], input[1..-1].to_i]
    case action
    when 'F'
      move(@direction, value)
    when 'L'
      left(value)
    when 'R'
      right(value)
    else
      move(action, value)
    end
  end

  def left(value)
    dir = dir_to_int(@direction)
    dir -= value/90
    @direction = int_to_dir(dir)
  end

  def right(value)
    dir = dir_to_int(@direction)
    dir += value/90
    @direction = int_to_dir(dir)
  end

  def count
    @x.abs + @y.abs
  end
end

class Waypoint
  include Movable

  def initialize(boat, x, y)
    @boat = boat
    @x = x
    @y = y
  end

  def direction(input)
    action, value = [input[0], input[1..-1].to_i]
    case action
    when 'F'
      @boat.move('N',  @y * value)
      @boat.move('E',  @x * value)
    when 'L'
      left(value)
    when 'R'
      right(value)
    else
      move(action, value)
    end
  end

  def left(value)
    case value
    when 90
      @x, @y = [-@y, @x]
    when 180
      @x, @y = [-@x, -@y]
    when 270
      right(90)
    end
  end

  def right(value)
    case value
    when 90
      @x, @y = [@y, -@x]
    when 180
      @x, @y = [-@x, -@y]
    when 270
      left(90)
    end
  end
end

def star_1
  boat = Boat.new('E', 0, 0)
  TEST_INPUT.each {|i| boat.direction(i)}
  p "The test boat should move 25: #{boat.count == 25}"
  boat = Boat.new('E', 0, 0)
  INPUT.each {|i| boat.direction(i)}
  p "The boat moved #{boat.count}"
end

def star_2
  boat = Boat.new('E', 0, 0)
  waypoint = Waypoint.new(boat, 10, 1)
  TEST_INPUT.each {|i| waypoint.direction(i)}
  p "The test boat should move 286: #{boat.count == 286}"
  boat = Boat.new('E', 0, 0)
  waypoint = Waypoint.new(boat, 10, 1)
  INPUT.each {|i| waypoint.direction(i)}
  p "The boat moved: #{boat.count}"
end

star_1
star_2

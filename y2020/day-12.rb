#!/usr/bin/env ruby

INPUT = []
File.readlines('input/day-12.txt').each do |line|
  INPUT << line.chomp
end

TEST_INPUT = %w(F10 N3 F7 R90 F11)

class Boat
  def initialize(facing)
    @direction = facing
    @x = 0
    @y = 0
  end

  def dir_to_int(dir)
    {N: 0, E: 1, S: 2, W: 3}[dir.to_sym]
  end

  def int_to_dir(int)
    int = int.abs
    int -= 4 if int > 3
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

def star_1
  boat = Boat.new('E')
  TEST_INPUT.each {|i| boat.direction(i)}
  p "The test boat should move 25: #{boat.count == 25}"
  boat = Boat.new('E')
  INPUT.each {|i| boat.direction(i)}
  p boat
  p boat.count
end

def star_2
end

star_1
star_2

#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}"

INPUT = File.read(input_file) if File.exist?(input_file)

def star1(input, wide = 101, tall = 103, debug = false)
  w = (wide / 2).to_i
  t = (tall / 2).to_i
  quad = Array.new(4, 0)
  input.split("\n").map do |line|
    p line if debug
    loc, velo = line.match(/p=(\d+,\d+) v=(-?\d+,-?\d+)/).captures.map { |a| a.split(',').map(&:to_i) }
    # p loc, velo
    x, y = loc
    100.times do
      x = (x + velo[0]) % wide
      y = (y + velo[1]) % tall
    end
    loc = [x, y]
    p "End: #{loc}" if debug
    loc
  end.reject { |loc| loc[0] == w || loc[1] == t }.sort.each do |loc|
    x, y = loc
    if (x < w) && y < t
      quad[0] += 1
    elsif x > w && y < t
      quad[1] += 1
    elsif x < w && y > t
      quad[2] += 1
    else
      quad[3] += 1
    end
  end

  p quad if debug
  quad.inject(&:*)
end

# p "Test: #{star1(test_input, 11, 7, true)} == 12"
# p "Star 1: #{star1(INPUT)}"

def star2(input, debug = false)
  robots = input.split("\n").map do |line|
    loc, velo = line.match(/p=(\d+,\d+) v=(-?\d+,-?\d+)/).captures.map { |a| a.split(',').map(&:to_i) }
    # p loc, velo
    [loc, velo]
  end

  wide = 101
  tall = 103

  def calc(robots, wide, tall)
    w = (wide / 2).to_i
    t = (tall / 2).to_i

    quad = Array.new(4, 0)
    robots = robots.map do |loc, velo|
      x = (loc[0] + velo[0]) % wide
      y = (loc[1] + velo[1]) % tall
      [[x, y], velo]
    end

    robots.reject { |loc, _| loc[0] == w || loc[1] == t }.sort.each do |loc, _|
      x, y = loc
      if (x < w) && y < t
        quad[0] += 1
      elsif x > w && y < t
        quad[1] += 1
      elsif x < w && y > t
        quad[2] += 1
      else
        quad[3] += 1
      end
    end

    [quad.inject(&:*), robots]
  end

  min = -1

  10_000.times do |i|
    value, robots = calc(robots, wide, tall)
    min = value if min == -1

    next unless min > value

    min = value
    grid = Array.new(tall) { Array.new(wide, '.') }

    robots.each do |xy, _|
      x, y = xy
      grid[y][x] = 'X'
    end

    p i
    grid.each { |row| p row.join }
  end
end

# p "Test: #{star2(test_input, true)} == x"
p "Star 2: #{star2(INPUT)}"

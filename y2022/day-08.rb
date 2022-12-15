#!/usr/bin/env ruby

inputFile = "input/#{File.basename(__FILE__).split('.').first}.txt"

if File.exists?(inputFile)
  INPUT = File.read(inputFile)
end

testInput = '''30373
25512
65332
33549
35390'''

def check_north(value, map, y, x)
  (y-1).downto(0).each do |i|
    return false if map[i][x] >= value
  end

  return true
end

def check_east(value, map, y, x)
  (x+1).upto(map.length-1).each do |i|
    return false if map[y][i] >= value
  end

  return true
end

def check_south(value, map, y, x)
  (y+1).upto(map.length-1).each do |i|
    return false if map[i][x] >= value
  end

  return true
end

def check_west(value, map, y, x)
  (x-1).downto(0).each do |i|
    return false if map[y][i] >= value
  end

  return true
end

def is_visible?(value, map, y, x)
  return true if y == 0 || y == map.length - 1
  return true if x == 0 || x == map[y].length - 1

  check_north(value, map, y, x) ||
    check_east(value, map, y, x) ||
    check_south(value, map, y, x) ||
    check_west(value, map, y, x)
end

def create_map(input)
  input.split.map { |line| line.chomp.chars.map(&:to_i) }
end

def star_1(input)
  map = create_map(input)

  visible = 0
  map.each_with_index do |inner, y|
    inner.each_with_index do |value, x|
      visible += 1 if is_visible?(value, map, y, x)
    end
  end

  visible
end

p "Test: #{star_1(testInput)} == 21"

print "Star 1: "
p star_1(INPUT) if INPUT

def count_trees_north(value, map, y, x)
  counter = 0
  (y-1).downto(0).each do |i|
    tree = map[i][x]
    counter +=1
    break if tree >= value
  end

  counter
end

def count_trees_east(value, map, y, x)
  counter = 0
  (x+1).upto(map.length-1).each do |i|
    tree = map[y][i]
    counter +=1
    break if tree >= value
  end

  counter
end

def count_trees_south(value, map, y, x)
  counter = 0
  (y+1).upto(map.length-1).each do |i|
    tree = map[i][x]
    counter +=1
    break if tree >= value
  end

  counter
end

def count_trees_west(value, map, y, x)
  counter = 0
  (x-1).downto(0).each do |i|
    tree = map[y][i]
    counter +=1
    break if tree >= value
  end

  counter
end

def sum_scenic_score(value, map, y, x)
  return 0 if y == 0 || y == map.length - 1
  return 0 if x == 0 || x == map[y].length - 1
  
  count_trees_north(value, map, y, x) *
    count_trees_east(value, map, y, x) *
    count_trees_south(value, map, y, x) *
    count_trees_west(value, map, y, x)
end

def star_2(input)
  map = create_map(input)

  scenic_score = 0
  map.each_with_index do |inner, y|
    inner.each_with_index do |value, x|
      score = sum_scenic_score(value, map, y, x)
      scenic_score = [score, scenic_score].max
    end
  end

  scenic_score
end

p "Test: #{star_2(testInput)} == 8"

print "Star 2: "
p star_2(INPUT)

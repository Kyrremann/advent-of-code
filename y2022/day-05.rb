#!/usr/bin/env ruby

inputFile = "input/#{File.basename(__FILE__).split('.').first}.txt"

if File.exists?(inputFile)
  INPUT = File.read(inputFile)
end

testInput = '''    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2'''

def parse_boxes(boxes)
  columns = []
  boxes.each_line do |line|
    break unless line.chomp!
    index = 1
    (line.length / 4.0).ceil.times do |i|
      value = line[index]
      columns[i] = columns[i] ? columns[i]+value : value unless value == " "
      index += 4
    end
  end
  columns
end

def CrateMover9000(commands, boxes)
  commands.each_line do |command|
    move, from, to = command.match(/move (\d+) from (\d+) to (\d+)/).captures.map(&:to_i)
    boxes[to-1] = boxes[from-1][0..move-1].reverse + boxes[to-1]
    boxes[from-1] = boxes[from-1][move..-1]
  end
  boxes.map{|c| c[0] }.join
end

def star_1(input)
  boxes, commands = input.split("\n\n")
  boxes = parse_boxes(boxes)

  CrateMover9000(commands, boxes)
end

p "Test: #{star_1(testInput)} == 'CMZ'"

print "Star 1: "
p star_1(INPUT) if INPUT

def CrateMover9001(commands, boxes)
  commands.each_line do |command|
    move, from, to = command.match(/move (\d+) from (\d+) to (\d+)/).captures.map(&:to_i)
    boxes[to-1] = boxes[from-1][0..move-1] + boxes[to-1]
    boxes[from-1] = boxes[from-1][move..-1]
  end
  boxes.map{|c| c[0] }.join
end

def star_2(input)
  boxes, commands = input.split("\n\n")
  boxes = parse_boxes(boxes)

  CrateMover9001(commands, boxes)
end

p "Test: #{star_2(testInput)} == 12"

print "Star 2: "
p star_2(INPUT)

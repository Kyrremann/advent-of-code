#!/usr/bin/env ruby

inputFile = "input/#{File.basename(__FILE__).split('.').first}.txt"

if File.exists?(inputFile)
  INPUT = File.read(inputFile)
end

testInput = '''addx 15
addx -11
addx 6
addx -3
addx 5
addx -1
addx -8
addx 13
addx 4
noop
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx -35
addx 1
addx 24
addx -19
addx 1
addx 16
addx -11
noop
noop
addx 21
addx -15
noop
noop
addx -3
addx 9
addx 1
addx -3
addx 8
addx 1
addx 5
noop
noop
noop
noop
noop
addx -36
noop
addx 1
addx 7
noop
noop
noop
addx 2
addx 6
noop
noop
noop
noop
noop
addx 1
noop
noop
addx 7
addx 1
noop
addx -13
addx 13
addx 7
noop
addx 1
addx -33
noop
noop
noop
addx 2
noop
noop
noop
addx 8
noop
addx -1
addx 2
addx 1
noop
addx 17
addx -9
addx 1
addx 1
addx -3
addx 11
noop
noop
addx 1
noop
addx 1
noop
noop
addx -13
addx -19
addx 1
addx 3
addx 26
addx -30
addx 12
addx -1
addx 3
addx 1
noop
noop
noop
addx -9
addx 18
addx 1
addx 2
noop
noop
addx 9
noop
noop
noop
addx -1
addx 2
addx -37
addx 1
addx 3
noop
addx 15
addx -21
addx 22
addx -6
addx 1
noop
addx 2
addx 1
noop
addx -10
noop
noop
addx 20
addx 1
addx 2
addx 2
addx -6
addx -11
noop
noop
noop'''

def create_stack(input)
  stack = []
  input.each_line do |line|
    case line
    when /noop/
      stack << ["noop"]
    when /addx/
      stack << ["noop"]
      stack << line.match(/(addx)\s(-?\d+)/).captures
    end
  end

  stack
end

def create_cycles(stack)
  cycle = 0
  xs = [1]

  stack.each do |instruction, value|
    cycle += 1

    case instruction
    when "noop"
      xs[cycle] = xs[cycle-1]
    when "addx"
      xs[cycle] = xs[cycle-1] + value.to_i
    end
  end

  xs
end

def star_1(input)
  stack = create_stack(input)
  xs = create_cycles(stack)

  signalStrengths = []
  xs.each_with_index do |x, cycle|
    cycle += 1
    if [20, 60, 100, 140, 180, 220].include?(cycle)
      signalStrengths << cycle * x
    end
  end

  signalStrengths.sum
end

p "Test: #{star_1(testInput)} == 13140"

print "Star 1: "
p star_1(INPUT) if INPUT

def star_2(input)
  stack = create_stack(input)
  xs = create_cycles(stack)

  crt = ["", "", "", "", "", ""]
  row = 0
  rowIndex = 0
  
  xs.each_with_index do |x, index|
    sprite = '.' * 40
    sprite[x-1] = '#'
    sprite[x] = '#'
    sprite[x+1] = '#'

    if sprite[rowIndex] == '#'
      crt[row] += '#'
    else
      crt[row] += '.'
    end

    rowIndex += 1
    if [39, 79, 119, 159, 199].include?(index)
      row += 1
      rowIndex = 0
    end
  end

  crt.join("\n")
end

puts star_2(testInput)

puts "Star 2"
puts star_2(INPUT)

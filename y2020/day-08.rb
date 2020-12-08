#!/usr/bin/env ruby

INPUT = []
File.readlines('input/day-08.txt').each do |line|
  INPUT << line.chomp
end


TEST_INPUT = '''nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6'''.split("\n")

def acc_before_inifinit_loop(input, silence_loops=false)
  line_history = []
  index = 0
  acc = 0
  while index < input.length do
    line_history << index
    cmd, value = input[index].split
    if cmd == 'jmp'
      index += value.to_i
    else
      acc += value.to_i if cmd == 'acc'
      index += 1
    end

    if line_history.include?(index)
      p "loop with acc #{acc}" unless silence_loops
      return acc
    end
  end
  p "no loop with acc #{acc}"
  acc
end

def brute_force_find_bug(input)
  input.each_with_index do |line, index|
    cmd, value = line.split
    tmp = input.clone

    case cmd
    when 'nop'
      tmp[index] = line.sub('nop', 'jmp')
    when 'jmp'
      tmp[index] = line.sub('jmp', 'nop')
    when 'acc'
      next
    end

    acc_before_inifinit_loop(tmp, true)
  end
end

def star_1
  acc_before_inifinit_loop(TEST_INPUT)
  acc_before_inifinit_loop(INPUT)
end

def star_2
  brute_force_find_bug(TEST_INPUT)
  brute_force_find_bug(INPUT)
end

star_1
star_2

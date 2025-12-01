#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = 'Register A: 729
Register B: 0
Register C: 0

Program: 0,1,5,4,3,0'

def format(input)
  registers, program = input.split("\n\n")
  registers = registers.split("\n").map { |line| line.split.last }.map(&:to_i)
  program = program.split.last.split(',').map(&:to_i)

  [registers, program]
end

def combo(registers, operand)
  # Combo operands 0 through 3 represent literal values 0 through 3.
  # Combo operand 4 represents the value of register A.
  # Combo operand 5 represents the value of register B.
  # Combo operand 6 represents the value of register C.
  # Combo operand 7 is reserved and will not appear in valid programs.

  case operand
  when 0, 1, 2, 3
    operand
  when 4
    registers[0]
  when 5
    registers[1]
  when 6
    registers[2]
  else
    exit p "Operand #{operand} found!"
  end
end

def star1(input, debug = false)
  registers, program = format(input)

  puts "Program: #{program}" if debug
  pointer = 0
  output = []

  while pointer < program.length
    opcode = program[pointer]
    operand = program[pointer + 1]
    combo_operand = combo(registers, operand)

    puts "Registers: A(#{registers[0]}), B(#{registers[1]}), C(#{registers[2]})" if debug
    puts "Pointer: #{pointer}, Opcode: #{opcode}, Operand: #{operand} (combo: #{combo_operand})\n\n" if debug

    case opcode
    when 0
      # The adv instruction (opcode 0) performs division. The numerator is the value in the A register. The denominator is found by raising 2 to the power of the instruction's combo operand. (So, an operand of 2 would divide A by 4 (2^2); an operand of 5 would divide A by 2^B.) The result of the division operation is truncated to an integer and then written to the A register.
      registers[0] = (registers[0] / (2**combo_operand)).to_i
    when 1
      # The bxl instruction (opcode 1) calculates the bitwise XOR of register B and the instruction's literal operand, then stores the result in register B.
      registers[1] = registers[1] ^ operand
    when 2
      # The bst instruction (opcode 2) calculates the value of its combo operand modulo 8 (thereby keeping only its lowest 3 bits), then writes that value to the B register.
      registers[1] = combo_operand % 8
    when 3
      # The jnz instruction (opcode 3) does nothing if the A register is 0. However, if the A register is not zero, it jumps by setting the instruction pointer to the value of its literal operand; if this instruction jumps, the instruction pointer is not increased by 2 after this instruction.
      if registers[0] != 0
        pointer = operand
        next
      end
    when 4
      # The bxc instruction (opcode 4) calculates the bitwise XOR of register B and register C, then stores the result in register B. (For legacy reasons, this instruction reads an operand but ignores it.)
      registers[1] = registers[1] ^ registers[2]
    when 5
      # The out instruction (opcode 5) calculates the value of its combo operand modulo 8, then outputs that value. (If a program outputs multiple values, they are separated by commas.)
      output << combo_operand % 8
    when 6
      # The bdv instruction (opcode 6) works exactly like the adv instruction except that the result is stored in the B register. (The numerator is still read from the A register.)
      registers[1] = (registers[0] / (2**combo_operand)).to_i
    when 7
      # The cdv instruction (opcode 7) works exactly like the adv instruction except that the result is stored in the C register. (The numerator is still read from the A register.)
      registers[2] = (registers[0] / (2**combo_operand)).to_i
    else
      p "Unknown: #{cmd}"
    end

    pointer += 2
  end

  output.join(',')
end

p "Test: #{star1(test_input, true)} == 4,6,3,5,6,3,5,2,1,0"
p "Star 1: #{star1(INPUT)}"

# def star2(input, debug = false)
# end
#
# p "Test: #{star2(test_input, true)} == x"
# p "Star 2: #{star2(INPUT)}"

#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = 'L68
L30
R48
L5
R60
L55
L1
L99
R14
L82'

def star1(input)
  index = 50

  states = input.split.map do |line|
    direction = line[0]
    value = line[1..].to_i

    index = if direction == 'R'
              (index + value) % 100
            else
              (index - value) % 100
            end
  end

  states.count(&:zero?)
end

p "Test: #{star1(test_input)} == 3"

p "Star 1: #{star1(INPUT)}"

def star2(input)
  index = 50
  zeros = 0

  input.split.each do |line|
    direction = line[0]
    value = line[1..].to_i

    if direction == 'R'
      value.times do |_|
        index += 1

        if index > 99
          index = 0
          zeros += 1
        end
      end
    else
      value.times do |_|
        index -= 1

        zeros += 1 if index.zero?
        index = 99 if index.negative?
      end
    end
  end

  zeros
end

p "Test: #{star2(test_input)} == 6"

p "Star 2: #{star2(INPUT)}"

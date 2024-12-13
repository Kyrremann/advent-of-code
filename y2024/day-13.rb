#!/usr/bin/env ruby
# frozen_string_literal: true

require 'prime'

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}"

INPUT = File.read(input_file) if File.exist?(input_file)

# 135 = 67 + 34 + 34
# 210 = 22 + 94 + 94
# 8400/210 = 40
# 5400/135 = 40
# A * 40 = 80
# B * 40 = 40

test_input = 'Button A: X+94, Y+34
Button B: X+22, Y+67
Prize: X=8400, Y=5400

Button A: X+26, Y+66
Button B: X+67, Y+21
Prize: X=12748, Y=12176

Button A: X+17, Y+86
Button B: X+84, Y+37
Prize: X=7870, Y=6450

Button A: X+69, Y+23
Button B: X+27, Y+71
Prize: X=18641, Y=10279'

class Machine
  def set_a(xy)
    @ax, @ay = xy.split(', ').map { |v| v.split('+').last.to_i }
  end

  def set_b(xy)
    @bx, @by = xy.split(', ').map { |v| v.split('+').last.to_i }
  end

  def set_prize(xy, offset = 0)
    @px, @py = xy.split(', ').map { |v| v.split('=').last.to_i + offset }
  end

  def prize
    # A = (p_x*b_y - prize_y*b_x) / (a_x*b_y - a_y*b_x)
    # B = (a_x*p_y - a_y*p_x) / (a_x*b_y - a_y*b_x)
    # ---
    # A = (8400\*67 - 5400\*22) / (94\*67 - 34\*22) = 80
    # B = (8400\*34 - 5400\*94) / (94\*67 - 34\*22) = 40

    # p @px
    # divs = @px.prime_division
    # p divs

    # p "Button A: X+#{@ax}, Y+#{@ay}"
    # p "Button B: X+#{@bx}, Y+#{@by}"
    # p "Prize: X=#{@px}, Y=#{@py}"

    del = (@ax * @by - @ay * @bx)
    a = (@px * @by - @py * @bx) / del
    # b = (@px * @ay - @py * @ax) / del
    b = (@py * @ax - @px * @ay) / del

    # p "A: #{a}, B: #{b}"

    a * @ax + b * @bx == @px && a * @ay + b * @by == @py ? a * 3 + b : 0
  end
end

def star1(input, debug = false)
  def format(input)
    machines = []
    input.split("\n\n").each do |block|
      m = Machine.new
      block.split("\n").each do |line|
        type, xy = line.split(': ')
        type = type.split.last
        case type
        when 'A'
          m.set_a(xy)
        when 'B'
          m.set_b(xy)
        else
          m.set_prize(xy)
        end
      end
      machines << m
    end

    machines
  end

  machines = format(input)
  machines.sum { |m| m.prize }
end

p "Test: #{star1(test_input, true)} == 480"
p "Star 1: #{star1(INPUT)}"

def star2(input, debug = false)
  def format(input)
    machines = []
    input.split("\n\n").each do |block|
      m = Machine.new
      block.split("\n").each do |line|
        type, xy = line.split(': ')
        type = type.split.last
        case type
        when 'A'
          m.set_a(xy)
        when 'B'
          m.set_b(xy)
        else
          m.set_prize(xy, 10_000_000_000_000)
        end
      end
      machines << m
    end

    machines
  end

  machines = format(input)
  machines.sum { |m| m.prize }
end

p "Test: #{star2(test_input, true)} == x"
p "Star 2: #{star2(INPUT)}"

#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = 'MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX'

def horizontal(input)
  count = 0

  input.split("\n").each do |line|
    index = 0
    while matchdata = line.match(/XMAS|SAMX/, index)
      index = matchdata.begin(0) + 1
      count += 1
    end
  end

  count
end

def vertical(input)
  def xmas(input, y, x)
    # Down
    xmas = %w[S A M X]
    down = (y...input.length).sum do |yy|
      next_char = xmas.pop
      break 1 unless next_char

      break 0 if input[yy][x] != next_char

      0
    end

    # Up
    xmas = %w[S A M X]
    up = y.downto(0).sum do |yy|
      next_char = xmas.pop
      break 1 unless next_char

      break 0 if input[yy][x] != next_char

      0
    end

    up + down
  end

  input = input.split("\n")
  (0...input.length).sum do |y|
    (0...input[y].length).sum do |x|
      next 0 unless input[y][x] == 'X'

      xmas(input, y, x)
    end
  end
end

def diagonal(input, debug = false)
  def xmas(input, y, x, debug)
    # Down left
    xmas = %w[S A M X]
    xx = x
    dl = if x < xmas.length - 1
           0
         else
           (y...input.length).sum do |yy|
             next_char = xmas.pop
             break 1 unless next_char

             break 0 if input[yy][xx] != next_char

             xx -= 1
             0
           end
         end

    # Down right
    xmas = %w[S A M X]
    xx = x
    dr = if x > input[y].length - xmas.length
           0
         else
           (y...input.length).sum do |yy|
             next_char = xmas.pop
             break 1 unless next_char

             break 0 if input[yy][xx] != next_char

             xx += 1
             0
           end
         end

    # Up left
    xmas = %w[S A M X]
    xx = x
    ul = if x < xmas.length - 1
           0
         else
           y.downto(0).sum do |yy|
             next_char = xmas.pop
             break 1 unless next_char

             break 0 if input[yy][xx] != next_char

             xx -= 1
             0
           end
         end

    # Up right
    xmas = %w[S A M X]
    xx = x
    ur = if x > input[y].length - xmas.length
           0
         else
           y.downto(0).sum do |yy|
             next_char = xmas.pop
             break 1 unless next_char

             break 0 if input[yy][xx] != next_char

             xx += 1
             0
           end
         end

    print x, ': ', [dl, dr, ul, ur], "\n" if debug
    dl + dr + ul + ur
  end

  input = input.split("\n")
  (0...input.length).sum do |y|
    print y, ': ', input[y], "\n" if debug
    (0...input[y].length).sum do |x|
      next 0 unless input[y][x] == 'X'

      xmas(input, y, x, debug)
    end
  end
end

def star1(input, debug = false)
  [
    horizontal(input),
    vertical(input),
    diagonal(input, debug)
  ].sum
end

p "Test: #{star1(test_input, true)} == 18"
p "Star 1: #{star1(INPUT)}"
#
# def star2(input)
# end
#
# p "Test: #{star2(test_input)} == 31"
# p "Star 2: #{star2(INPUT)}"

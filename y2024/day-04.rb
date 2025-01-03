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

def star1(input, debug = false)
  def xmas_horizontal(line, debug = false)
    horizontal = 0
    index = 0

    while matchdata = line.match(/XMAS|SAMX/, index)
      index = matchdata.begin(0) + 1
      horizontal += 1
    end

    horizontal
  end

  def xmas(input, y, x, debug = false)
    # Down
    xmas = %w[S A M X]
    down = (y...input.length).sum do |yy|
      next_char = xmas.pop
      break 1 unless next_char

      print yy, ': ', input[yy], ', ', next_char, '=', input[yy][x], "\n" if debug && y == 6

      break 0 if input[yy][x] != next_char
      break 1 if xmas.empty?

      0
    end

    # Up
    xmas = %w[S A M X]
    up = y.downto(0).sum do |yy|
      next_char = xmas.pop
      break 1 unless next_char

      break 0 if input[yy][x] != next_char
      break 1 if xmas.empty?

      0
    end

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
             break 1 if xmas.empty?

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
             break 1 if xmas.empty?

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
             break 1 if xmas.empty?

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
             break 1 if xmas.empty?

             xx += 1
             0
           end
         end

    print "\t", x, ': ', { up:, down:, dl:, dr:, ul:, ur: }, "\n" if debug
    [up, down, dl, dr, ul, ur].sum
  end

  input = input.split("\n")
  (0...input.length).sum do |y|
    horizontal = xmas_horizontal(input[y], debug)
    print y, ': ', input[y], ', H: ', horizontal, "\n" if debug

    horizontal + (0...input[y].length).sum do |x|
      next 0 unless input[y][x] == 'X'

      xmas(input, y, x, debug)
    end
  end
end

p "Test: #{star1(test_input)} == 18"
p "Star 1: #{star1(INPUT)}"

def star2(input, debug = false)
  def xmas(input, y, x, debug = false)
    # A is here y, x
    # M.S -1,-1 . -1,+1
    # .A.       0
    # M.S +1,-1   +1,+1

    return 0 if y == 0 || y + 1 == input.length
    return 0 if x == 0 || x + 1 == input[y].length

    if ([
      input[y - 1][x - 1] == 'M' &&
        input[y + 1][x + 1] == 'S',

      input[y - 1][x + 1] == 'M' &&
        input[y + 1][x - 1] == 'S',

      input[y - 1][x - 1] == 'S' &&
        input[y + 1][x + 1] == 'M',

      input[y - 1][x + 1] == 'S' &&
        input[y + 1][x - 1] == 'M'
    ].count { |v| v }) == 2
      1
    else
      0
    end
  end

  input = input.split("\n")
  (0...input.length).sum do |y|
    print y, ': ', input[y], "\n" if debug

    (0...input[y].length).sum do |x|
      next 0 unless input[y][x] == 'A'

      xmas(input, y, x, debug)
    end
  end
end

p "Test: #{star2(test_input)} == 9"
p "Star 2: #{star2(INPUT)}"

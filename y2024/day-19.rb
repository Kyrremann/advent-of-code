#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = 'r, wr, b, g, bwu, rb, gb, br

brwrr
bggr
gbbr
rrbgbr
ubwu
bwurrg
brgr
bbrgwb'

test_input2 = 'rrwru, uubbb, rwru, ubbb, grrr, ruwu, rgug, uwuu, uugg, wruu, uugb, gbrg, ubb, ugg, gbr, rbr, ruu, bgb, bbb, rwr, bbr, rgu, bgr, grr, gbg, uwu, wuu, bbw, bwr, rrw, brg, ugr, ruw, gub, wrb, uub, ugb, wru, grg, rbg, gug, rgr, ggu, rrr, uug, gru, bru, rw, gr, ub, bw, bb, bg, ug, ru, gb, gu, wr, gg, rb, wu, rr, uu, rg, u, w, b, g


rbgruwuugbgbrgrgugrgrrrwruuggubbwrbruubbbr'

def format(input)
  towels, patterns = input.split("\n\n")

  [towels.split(', '), patterns.split("\n")]
end

def possible?(towels, design, pattern, from)
  return true if design == pattern

  l = 1
  l += 1 while towels.include?(design[from, l])
  l -= 1

  puts "Found '#{design[0, l]}'"
  p from, l
  p design[from, l]
  p design[from + l, 1]
  exit
  possible?(towels, design, pattern, from + l)

  false
end

def star1(input, debug = false)
  towels, patterns = format(input)

  patterns.select do |pattern|
    selected = towels.select { |towel| pattern.include?(towel) }.sort_by(&:length).reverse

    regexp = "#{selected.join('|')}"
    design = pattern.scan(/#{regexp}/)

    next true if design.join.length >= pattern.length

    if debug
      p selected
      puts pattern
      puts "#{design}, #{regexp}"
      puts ''
    end

    # possible?(pattern, design
    false
  end.count
end

p "Test: #{star1(test_input, true)} == 6"
p "Test: #{star1(test_input2, true)} == 1"
# p "Star 1: #{star1(INPUT)}"

# def star2(input, debug = false)
# end
#
# p "Test: #{star2(test_input, true)} == x"
# p "Star 2: #{star2(INPUT)}"

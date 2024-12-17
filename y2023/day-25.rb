#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).split('.').first}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = 'jqt: rhn xhk nvd
rsh: frs pzl lsr
xhk: hfx
cmg: qnr nvd lhk bvb
rhn: xhk bvb hfx
bvb: xhk hfx
pzl: lsr hfx nvd
qnr: nvd
ntq: jqt hfx bvb xhk
nvd: lhk
lsr: lhk
rzs: qnr cmg lsr rsh
frs: qnr lhk lsr'

def star1(input)
  input.split("\n").map do |group|
    first, last = group.split(': ')
    puts first
    last.split(' ').each do |item|
      puts "  #{item}"
    end
  end
end

p "Test: #{star1(test_input)} == 35"

print 'Star 1: '
p star1(INPUT)

def star2(input)
end

p "Test: #{star2(test_input)} == 46"

print 'Star 2: '
p star2(INPUT)

#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = 'kh-tc
qp-kh
de-cg
ka-co
yn-aq
qp-ub
cg-tb
vc-aq
tb-ka
wh-tc
yn-cg
kh-ub
ta-co
de-co
tc-td
tb-wq
wh-td
ta-ka
td-qp
aq-cg
wq-ub
ub-vc
de-ta
wq-aq
wq-vc
wh-yn
ka-de
kh-ta
co-tc
wh-qp
tb-vc
td-yn'

def star1(input, debug = false)
  connections = input.split("\n").map { |c| c.split('-') }
  networks = Hash.new { |hsh, key| hsh[key] = [] }

  connections.each do |a, b|
    networks[a] = networks[a] << b
    networks[b] = networks[b] << a
  end

  if debug
    puts networks
    key = 'ka'
    print key, ': ', networks[key], "\n"
    networks[key].each { |k| print k, ': ', networks[k], "\n" }
    puts ''
  end

  found = {}

  networks.each do |key, values|
    values.each do |pins|
      values.each do |vv|
        next if pins == vv

        next unless networks[pins].include?(vv) && networks[vv].include?(pins)

        list = [key, pins, vv].sort

        found[list] = '' if list.any? { |pins| pins.start_with?('t') }
      end
    end
  end

  p 'I found' if debug
  found.keys.sort.each { |k| p k } if debug

  found.select { |k, pins| pins }.keys.size
end

p "Test: #{star1(test_input, true)} == 7"
p "Star 1: #{star1(INPUT)}"

def star2(input, debug = false)
  connections = input.split("\n").map { |c| c.split('-') }
  networks = Hash.new { |hsh, key| hsh[key] = [] }

  connections.each do |a, b|
    networks[a] = networks[a] << b
    networks[b] = networks[b] << a
  end

  networks.each { |k, pins| networks[k] = pins.append(k).sort }

  found = Hash.new(0)

  networks.each do |key, values|
    print key, ': ', values, "\n" if debug

    networks.each do |k, pins|
      next if key == k

      intersection = values.intersection(pins)
      print "\t& ", k, ': ', intersection, "\n" if debug

      found[intersection] += 1 if intersection.size > 3
    end
  end

  p found if debug
  found.max { |a, b| a.last <=> b.last }.first.join(',')
end

p "Test: #{star2(test_input, true)} == co,de,ka,ta"
p "Star 2: #{star2(INPUT)}"
# am,aq,by,ge,gf,ie,mr,mt,rw,sn,te,yi,zb

#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).split('.').first}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483'

def find_highest(cards)
  highest = cards.detect { |e| cards.count(e) > 1 }
  return highest if highest

  strength = { 'T' => 10, 'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14 }
  cards.max do |a, b|
    ac = strength.key?(a) ? strength[a] : a.to_i
    bc = strength.key?(b) ? strength[b] : b.to_i
    ac <=> bc
  end
end

def trixing(cards)
  tmp = cards.dup
  tmp.delete('J')
  highest = find_highest(tmp)
  (5 - tmp.length).times do
    tmp << highest.to_s
  end
  tmp
end

def find_type(cards, joker: false)
  cards = trixing(cards) if joker

  return 7 if cards.uniq.length == 1
  return 6 if cards.uniq.length == 2 && cards.uniq.map { |c| cards.count(c) }.include?(4)
  return 5 if cards.uniq.length == 2
  return 4 if cards.uniq.length == 3 && cards.uniq.map { |c| cards.count(c) }.include?(3)
  return 3 if cards.uniq.length == 3
  return 2 if cards.uniq.length == 4

  1
end

class Hand
  attr_reader :type, :cards, :bid

  def initialize(cards, bid, joker: false)
    @cards = cards
    @bid = bid

    @type = find_type(@cards, joker: joker)
  end

  def to_s
    "#{@cards.join}, Bid #{@bid}, Type #{@type}"
  end
end

def sort(hands, joker: false)
  strength = { 'T' => 10, 'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14 }
  strength['J'] = 0 if joker
  hands.sort do |a, b|
    if a.type == b.type
      hands.length.times do |i|
        next if a.cards[i] == b.cards[i]

        ac = strength.key?(a.cards[i]) ? strength[a.cards[i]] : a.cards[i].to_i
        bc = strength.key?(b.cards[i]) ? strength[b.cards[i]] : b.cards[i].to_i
        break ac <=> bc
      end
    else
      a.type <=> b.type
    end
  end
end

def star1(input)
  hands = input.split(/\n/).map do |line|
    cards, bid = line.split
    Hand.new(cards.chars, bid.to_i)
  end

  hands = sort(hands)
  hands.each_with_index.map { |hand, index| hand.bid * (index + 1) }.sum
end

p "Test: #{star1(test_input)} == 6440"

print 'Star 1: '
p star1(INPUT)

def star2(input)
  hands = input.split(/\n/).map do |line|
    cards, bid = line.split
    Hand.new(cards.chars, bid.to_i, joker: true)
  end

  hands = sort(hands, joker: true)
  hands.each_with_index.map { |hand, index| hand.bid * (index + 1) }.sum
end

p "Test: #{star2(test_input)} == 5905"

print 'Star 2: '
p star2(INPUT)

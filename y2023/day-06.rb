#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).split('.').first}.txt"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = 'Time:      7  15   30
Distance:  9  40  200'

def hold(hold, time)
  rest = time - hold
  hold * rest
end

def find_better_times(times, distances)
  new_records = []

  times.each_with_index do |time, index|
    better = 0
    (0..time).each do |t|
      distance = hold(t, time)
      better += 1 if distance > distances[index]
    end
    new_records << better
  end

  new_records
end

def star1(input)
  times = input.split(/\n/).first.split(':').last.split.map(&:to_i)
  distances = input.split(/\n/).last.split(':').last.split.map(&:to_i)

  new_records = find_better_times(times, distances)
  new_records.inject(:*)
end

p "Test: #{star1(test_input)} == 288"

print 'Star 1: '
p star1(INPUT)

def star2(input)
  times = input.split(/\n/).first.split(':').last.split.join.to_i
  distances = input.split(/\n/).last.split(':').last.split.join.to_i

  new_records = find_better_times([times], [distances])
  new_records.max
end

p "Test: #{star2(test_input)} == 71503"

print 'Star 2: '
p star2(INPUT)

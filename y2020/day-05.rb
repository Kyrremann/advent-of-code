#!/usr/bin/env ruby

INPUT = []
File.readlines('input/day-05.txt').each do |line|
  INPUT << line.chomp
end

def parser(data, range)
  data.each do |d|
    left, right = range.each_slice((range.length/2.0).round).to_a
    if d == 'F' or d == 'L'
      range = left
    else
      range = right
    end
  end
  range.first
end


def find_seat(boarding_pass)
  matches = boarding_pass.match(/^(\w{7})(\w{3})$/)
  to_binary(matches)
end

## original solution
def to_range(matches)
  row = parser(matches[1].chars, (0..127).to_a)
  column = parser(matches[2].chars, (0..7).to_a)
  return row, column, (row * 8) + column
end

## first try on binary solution
def to_binary(matches)
  row = matches[1].gsub('F', '0').gsub('B', '1').to_i(2)
  column = matches[2].gsub('L', '0').gsub('R', '1').to_i(2)
  return row, column, (row * 8) + column
end

## if you only need the seat, this is the simplest wasy
def simple_binary(boarding_pass)
  boarding_pass.gsub(/[FL]/, '0').gsub(/[BR]/, '1').to_i(2)
end

def tests
  row, column, seat = find_seat('BFFFBBFRRR')
  p [row, column, seat]
  p row == 70 && column == 7 && seat == 567

  row, column, seat = find_seat('FFFBBBFRRR')
  p [row, column, seat]
  p row == 14 && column == 7 && seat == 119

  row, column, seat = find_seat('BBFFBBFRLL')
  p [row, column, seat]
  p row == 102 && column == 4 && seat == 820
end

def star_1
  p "Highest seat id: #{find_seat(INPUT.max {|a, b| find_seat(a) <=> find_seat(b)})}"
end

def star_2
  all_seats = (95..838).to_a
  seats = INPUT.map {|bp| simple_binary(bp)}.sort
  p "My seat id: #{(all_seats - seats)}"
end

tests
star_1
star_2

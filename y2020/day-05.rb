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
  row = parser(matches[1].chars, (0..127).to_a)
  column = parser(matches[2].chars, (0..7).to_a)
  return row, column, (row * 8) + column
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
  seats = INPUT.map {|bp| find_seat(bp)[2]}.sort
  p "My seat id: #{(all_seats - seats)}"
end

tests
star_1
star_2

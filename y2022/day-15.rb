#!/usr/bin/env ruby

inputFile = "input/#{File.basename(__FILE__).split('.').first}.txt"

if File.exists?(inputFile)
  INPUT = File.read(inputFile)
end

testInput = '''Sensor at x=2, y=18: closest beacon is at x=-2, y=15
Sensor at x=9, y=16: closest beacon is at x=10, y=16
Sensor at x=13, y=2: closest beacon is at x=15, y=3
Sensor at x=12, y=14: closest beacon is at x=10, y=16
Sensor at x=10, y=20: closest beacon is at x=10, y=16
Sensor at x=14, y=17: closest beacon is at x=10, y=16
Sensor at x=8, y=7: closest beacon is at x=2, y=10
Sensor at x=2, y=0: closest beacon is at x=2, y=10
Sensor at x=0, y=11: closest beacon is at x=2, y=10
Sensor at x=20, y=14: closest beacon is at x=25, y=17
Sensor at x=17, y=20: closest beacon is at x=21, y=22
Sensor at x=16, y=7: closest beacon is at x=15, y=3
Sensor at x=14, y=3: closest beacon is at x=15, y=3
Sensor at x=20, y=1: closest beacon is at x=15, y=3'''

def star_1(input, row)
  p "Row: y=#{row}"
  positions = {}
  beacons = []
  minX = 0
  input.each_line do |line|
    sx, sy, bx, by = line.match(/Sensor at x=(\d+), y=(\d+): closest beacon is at x=(-?\d+), y=(\d+)/).captures.map(&:to_i)
    
    taxicab = (sx-bx).abs + (sy-by).abs
    minX = [minX, sx, bx].min
    
    if sy + taxicab >= row && sy - taxicab <= row
      distance_from_row = (row - sy).abs
      scanned = ((distance_from_row - taxicab).abs * 2) + 1
      r = scanned/2
      (-r..r).each {|mod| positions[sx+mod] = 'x'}
    end

    beacons << bx if by == row
  end

  beacons.each {|x| positions.delete(x)}
  positions.size
end

p "Test: #{star_1(testInput, 10)} == 26"

p "Star 1: #{star_1(INPUT, 2_000_000)}"

def star_2(input)
end

p "Test: #{star_2(testInput)} == 12"

print "Star 2: "
p star_2(INPUT)

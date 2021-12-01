HEIGHTS = []
File.readlines('input/day-01.txt').each do |line|
  HEIGHTS << line.chomp.to_i
end

def star1(heights)
  prev = heights.first
  increments = 0
  heights.each do |height|
    if height > prev
      increments += 1
    end
    prev = height
  end

  return increments
end

p "There are #{star1(HEIGHTS)} measurements larger than the previous measurement"

def star2(heights)
  sums = []
  (0..heights.size).each do |i|
    set = heights[i...i+3]
    sums << set.sum
  end

  star1(sums)
end

p "There are #{star2(HEIGHTS)} measurements larger than the previous measurement"

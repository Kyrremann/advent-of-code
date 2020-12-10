#!/usr/bin/env ruby

INPUT = []
File.readlines('input/day-10.txt').each do |line|
  INPUT << line.chomp.to_i
end

TEST_INPUT = %w(16 10 15 5 1 11 7 19 6 12 4).map{|n|n.to_i}
TEST_INPUT_2 = %w(28 33 18 42 31 14 46 20 48 47 24 23 49 45 19 38 39 11 1 32 25 35 8 17 7 9 4 2 34 10 3).map{|n|n.to_i}

def joltare(input)
  input = input.push(0)
  input = input.sort
  input << input.last + 3
end

def jolference(input)
  jolts = joltare(input.clone)
  jolt1 = 0
  jolt3 = 0
  jolts.each_with_index do |n,i|
    next if i+1 == jolts.length
    case jolts[i+1] - n
    when 1
      jolt1 += 1
    when 3
      jolt3 += 1
    end
  end

  (jolt1 * jolt3)
end

def star_1
  p jolference(TEST_INPUT) == (7 * 5)
  p jolference(TEST_INPUT_2) == (22 * 10)
  p "The jolference is #{jolference(INPUT)}"
end

end

def star_2
end

star_1
star_2

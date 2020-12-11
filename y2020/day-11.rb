#!/usr/bin/env ruby

INPUT = File.read('input/day-11.txt').split("\n").join

TEST_INPUT = '''L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL'''.split("\n").join
def around(c, i, input, row_size)
  group = []
  range = 3
  if i%row_size==0 || i%row_size==9# første eller siste object per linje
    range = 2
  end

  unless i%row_size==0
    i = i-1
  end

  if i < row_size # first row
    group = (input[i, range] + input[i+row_size, range])
  elsif i > input.length - row_size # last row
    group = (input[i-row_size, range] + input[i, range])
  else
    group = (input[i-row_size, range] + input[i, range] + input[i+row_size, range])
  end
  group.count(c)
end

def check(input, row_size)
  tmp = input.clone
  #tmp = prepare(tmp, row_size)
  puts "in #{tmp.scan(/.{98}/)}"
  changed = false
  input.chars.each_with_index do |c,i|
    case c
    when 'L'
      if around('#', i, tmp, row_size) == 0
        input[i] = '#'
        changed = true
      end
    when '#'
      if around('#', i, tmp, row_size) >= 5
        input[i] = 'L'
        changed = true
      end
    end
  end
 # puts "out #{input.scan(/.{10}/)}"
  return input, changed
end

def chaos_stabilizer(input, row_size)
  changed = true
  while changed
    input, changed = check(input, row_size)
  end
  input.count('#')
end

def star_1
  p chaos_stabilizer(TEST_INPUT, 10) == 37
  p chaos_stabilizer(INPUT, 98)
end

def star_2
end

star_1
star_2

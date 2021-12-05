INPUT = []
File.readlines('input/day-04.txt').each do |line|
  INPUT << line.chomp
end

test = '''7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7
'''.split("\n")

def parse_input(input)
  numbers = input[0].split(',').map(&:to_i)
  boards = [[]]
  index = 0
  input[2..-1].each do |line|
    if line == ""
      index += 1
      boards[index] = []
      next
    end

    boards[index] = boards[index].concat(line.split.map(&:to_i))
  end

  return numbers, boards
end

def has_bingo?(board)
  board.each_slice(5) do |a|
    return true unless a.any?
  end

  (0...5).each do |i|
    return true unless board.values_at(*(i...board.length).step(5).to_a).any?
  end

  return false
end

def star1(numbers, boards)
  numbers.each do |n|
    boards.map do |b|
      b.map! {|v| v == n ? nil : v}
      if has_bingo?(b)
        return b.compact.sum * n
      end
    end
  end
end

numbers, boards = parse_input(test)
p "TEST: Bingo score is #{star1(numbers, boards)}"
numbers, boards = parse_input(INPUT)
p "Bingo score is #{star1(numbers, boards)}"


def star2(numbers, boards)
  numbers.each do |n|
    if boards.size > 1
    boards.select! do |b|
      b.map! {|v| v == n ? nil : v}
      !has_bingo?(b)
    end
    else
      boards.map do |b|
        b.map! {|v| v == n ? nil : v}
        if has_bingo?(b)
          return b.compact.sum * n
        end
      end
    end
  end
end

numbers, boards = parse_input(test)
p "TEST: Last bingo score is #{star2(numbers, boards)}"
numbers, boards = parse_input(INPUT)
p "Last bingo score is #{star2(numbers, boards)}"

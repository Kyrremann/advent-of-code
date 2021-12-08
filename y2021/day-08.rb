INPUT = []
File.readlines('input/day-08.txt').each do |line|
  INPUT << line.chomp
end

test = '''be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
'''.split("\n")

def star1(input)
  output = input.map{|l| l.split(' | ').last.chomp}
  output.sum{|o| o.split.select{|s| [2, 3, 4, 7].include?(s.size)}.size}
end

p star1(test)
p star1(INPUT)

def nine(input, numbers)
  input.each do |n|
    a = n.chars
    b = (numbers[4] + numbers[7]).chars.uniq
    c = (a-b | b-a)
    if c.size == 1
      return n
    end
  end
end

def zero(input, numbers)
  input.each do |n|
    next if n.size != 6
    next if n == numbers[9]
    return n if (n.chars - numbers[1].chars).size == 4
  end
end

def six(input, numbers)
  input.each do |n|
    next if n.size != 6 ||
            n == numbers[9] ||
            n == numbers[0]
    return n
  end
end

def five(input, numbers)
  segment = numbers[8].chars - numbers[6].chars
  five = numbers[9].chars - segment
  input.each do |n|
    return n if n.chars.sort == five.sort
  end
end

def two(input, numbers)
  input.each do |n|
    next if n.size != 5 ||
            n == numbers[5] ||
            n == numbers[3]
    return n
  end
end

def three(input, numbers)
  input.each do |n|
    next if n.size != 5
    return n if (n.chars - numbers[1].chars).size == 3
  end
end

def display(input, numbers)
  input.map {|n| numbers.key(n.chars.sort.join)}.join.to_i
end

def find_number(input, display)
  numbers = {}
  rest = []
  input.each do |n|
    case n.size
    when 2
      numbers[1] = n
    when 3
      numbers[7] = n
    when 4
      numbers[4] = n
    when 7
      numbers[8] = n
    else
      rest << n
    end
  end

  numbers[9] = nine(rest, numbers)
  numbers[0] = zero(rest, numbers)
  numbers[6] = six(rest, numbers)
  numbers[5] = five(rest, numbers)
  numbers[3] = three(rest, numbers)
  numbers[2] = two(rest, numbers)

  
  numbers.map {|k,n| numbers[k] = n.chars.sort.join}
  display(display, numbers)
end

def star2(data)
  data.sum do |line|
    input, display = line.split(' | ')
    find_number(input.split, display.split)
  end
end

p star2(test)
p star2(INPUT)

INPUT = []
File.readlines('input/day-10.txt').each do |line|
  INPUT << line.chomp
end

test = ['[({(<(())[]>[[{[]{<()<>>',
        '[(()[<>])]({[<{<<[]>>(',
        '{([(<{}[<>[]}>{[]{[(<()>',
        '(((({<>}<{<{<>}{[]{[]{}',
        '[[<[([]))<([[{}[[()]]]',
        '[{[{({}]{}}([{[{{{}}([]',
        '{<[[]]>}<{[{[{[]{()[[[]',
        '[<(<(<(<{}))><([]([]()',
        '<{([([[(<>()){}]>(<<{{',
        '<{([{{}}[<[[[<>{}]]]>[]]']

def legal?(input)
  stack = []
  input.chars do |s|
    case s
    when ')'
      if stack.last == '('
        stack.pop
      else
        return false, s
      end
    when ']'
      if stack.last == '['
        stack.pop
      else
        return false, s
      end
    when '}'
      if stack.last == '{'
        stack.pop
      else
        return false, s
      end
    when '>'
      if stack.last == '<'
        stack.pop
      else
        return false, s
      end
    else
      stack << s
    end
  end

  return true
end

def star1(input)
  symbols = []
  input.each do |line|
    legal, symbol = legal?(line)
    symbols << symbol unless legal
  end
  symbols.map { |s|
    case s
    when ')'
      3
    when ']'
      57
    when '}'
      1197
    when '>'
      25137
    end
  }.sum
end

p "TEST: Syntax Error Score: #{star1(test)}"
p "Syntax Error Score: #{star1(INPUT)}"

def star2(input)
  symbols = []
  legals = input.select do |line|
    legal, symbol = legal?(line)
    legal
  end

  legals.map { |line|
    stack = []
    line.chars do |s|
      case s
      when ')',']','}','>'
        stack.pop
      else
        stack << s
      end
    end

    score = 0
    stack.reverse.each do |symbol|
      score *= 5
      case symbol
      when '('
        score += 1
      when '['
        score += 2
      when '{'
        score += 3
      when '<'
        score += 4
      end
    end

    score
  }.sort[legals.size/2]
end

p "TEST: Middle score: #{star2(test)}"
p "Middle score: #{star2(INPUT)}"

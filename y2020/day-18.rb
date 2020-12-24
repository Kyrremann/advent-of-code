#!/usr/bin/env ruby

INPUT = []
File.readlines('input/day-18.txt').each do |line|
  INPUT << line.chomp
end

TEST_INPUT = [
  ["1 + 2 * 3 + 4 * 5 + 6", 71],
  ["1 + (2 * 3) + (4 * (5 + 6))", 51],
  ["2 * 3 + (4 * 5)", 26],
  ["5 + (8 * 3 + 9 + 3 * 4 * 3)", 437],
  ["5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))", 12240],
  ["((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2", 13632]
]

def rpn(input)
  output = []
  operators = []
  input.each do |n|
    case n
    when /[0-9]/
      output << n.to_i
    when /[+*]/
      if operators.empty?
        operators << n
      else
        while operators.last != "(" and
             not operators.empty? do
          output << operators.pop
        end
        operators << n
      end
    when /\(/
      operators << n
    when /\)/
      while operators.last != "("
        output << operators.pop
      end
      operators.pop if operators.last == "("
    end
  end
  output.concat(operators)
  output
end

def evaluate_rpn(expression)
  stack = []
  expression.each do |token|
    case token
    when 1..9
      stack << token
    when /[+*]/
      lhs = stack.pop
      rhs = stack.pop
      stack.push(lhs.send(token, rhs))
    end
  end
  stack.pop
end

def math(input)
  input = input.split.map {|i| i.split(/(\(|\))/)}.flatten.reject { |c| c.empty? }
  expression = rpn(input)
  evaluate_rpn(expression)
end

def star_1
  TEST_INPUT.each do |input|
    output = math(input.first)
    p "#{input.first} = #{output} is #{output == input.last}"
  end

  p "All together #{INPUT.sum { |input| math(input) }}"
end

def star_2
end

star_1
star_2

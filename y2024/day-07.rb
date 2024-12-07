#!/usr/bin/env ruby
# frozen_string_literal: true

require 'time'

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = '190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
'

def format(input)
  input.split("\n").map { |line| line.split(': ') }
end

def star1(input, debug = false)
  input = format(input)
  input.select do |row|
    eval = row[0].to_i
    numbers = row[1].split.map(&:to_i)

    print eval, ': ', numbers, ' -- ', Time.now, "\n"
    operators = []

    (0...numbers.length).each do |i|
      operators << '+' * i + '*' * (numbers.length - 1 - i)
    end

    print 'Operators: ', operators, "\n"

    def is_true(operators, numbers, eval, debug)
      operators.map do |op|
        print 'Checking: ', op, "\n" if debug
        if op.chars.all? { |x| x == op[0] }
          return true if eval == case op[0]
                                 when '*'
                                   numbers.reduce(&:*)
                                 when '+'
                                   numbers.reduce(&:+)
                                 end
        else
          op.chars.permutation.map do |perm|
            print 'Permutation: ', perm if debug

            cp = numbers.map(&:clone)
            perm.each_with_index do |op, i|
              cp.insert(i + i + 1, op)
            end
            print ' -> ', cp, "\n" if debug

            def math(values, debug = false)
              p values if debug
              while values.length > 1
                first = values.pop.to_i
                op = values.pop
                second = values.pop.to_i

                output = case op
                         when '*'
                           first * second
                         when '+'
                           first + second
                         end

                print first, op, second, '=', output, "\n" if debug
                values.append(output)
                p values if debug
              end
              values.first
            end

            return true if math(cp.reverse, debug) == eval
          end
        end

        p 'Not valid' if debug
      end
      false
    end

    is_true(operators, numbers, eval, debug)
  end.map { |row| row[0].to_i }.sum
end

p "Test: #{star1(test_input, true)} == 3749"
p "Star 1: #{star1(INPUT)}"

# def star2(input)
# end
#
# p "Test: #{star2(test_input)} == x"
# p "Star 2: #{star2(INPUT)}"

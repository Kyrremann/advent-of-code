#!/usr/bin/env ruby

PASSWORDS = []
File.readlines('input/day-2.txt').each do |line|
  PASSWORDS << line.chomp
end

REGEX = /(?<range>\d+-\d+)\s(?<letter>\w):\s(?<password>\w+)/

def star_1
  correct_passwords_counter = 0
  PASSWORDS.each do |p|
    matches = p.match(REGEX)
    if matches
      range = matches[:range]
      letter = matches[:letter]
      password = matches[:password]

      s,e = range.split('-')
      if password.scan(/#{letter}/).count.between?(s.to_i, e.to_i)
        correct_passwords_counter += 1
      end
    end
  end

  p correct_passwords_counter
end

def star_2
end

star_1
star_2

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
  correct_passwords_counter = 0
  PASSWORDS.each do |p|
    matches = p.match(/(?<first>\d+)-(?<second>\d+)\s(?<letter>\w):\s(?<password>\w+)/)
    if matches
      first = matches[:first].to_i - 1
      second = matches[:second].to_i - 1
      letter = matches[:letter]
      password = matches[:password]

      if (password[first] == letter and password[second] != letter) or (password[first] != letter and password[second] == letter)
        correct_passwords_counter += 1
      end
    end
  end

  p correct_passwords_counter
end

star_1
star_2

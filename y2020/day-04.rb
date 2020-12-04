#!/usr/bin/env ruby

INPUT = [{}]
counter = 0
File.readlines('input/day-04.txt').each do |line|
  line = line.chomp
  if line == ""
    counter += 1
    INPUT[counter] = {}
    next
  end

  line.split.each do |data|
    key, value = data.split(':')
    INPUT[counter][key] = value
  end
end

VALID_KEYS = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']

def star_1
  valid_passports = 0
  INPUT.each do |passport|
    if (VALID_KEYS & passport.keys).length == 7
      valid_passports += 1
    end
  end
  p "Valid passports: #{valid_passports}"
end

def valid_heigth(heigth)
  if heigth.include? 'cm'
    heigth.to_i.between?(150, 193)
  elsif heigth.include? 'in'
    heigth.to_i.between?(59, 76)
  else
    false
  end
end

def valid_passport?(passport)
  [
    passport['byr'].to_i.between?(1920, 2002),
    passport['iyr'].to_i.between?(2010, 2020),
    passport['eyr'].to_i.between?(2020, 2030),
    valid_heigth(passport['hgt']),
    (passport['hcl'] =~ /^#[0-9a-f]{6}$/) == 0,
    ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'].include?(passport['ecl']),
    (passport['pid'] =~ /^\d{9}$/) == 0
  ].all?
end

def star_2
  valid_passports = 0
  INPUT.each do |passport|
    if (VALID_KEYS & passport.keys).length == 7
      valid_passports += 1 if valid_passport?(passport)
    end
  end
  p "Valid passports: #{valid_passports}"
end

star_1
star_2

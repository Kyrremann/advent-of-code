#!/usr/bin/env ruby

SALT = 20201227
DOOR_PUBLIC_KEY = 7573546
CARD_PUBLIC_KEY = 17786549

def calculate_encryption_key(subject, loop)
  value = 1
  loop.times do |i|
    value = (value * subject).remainder(SALT)
  end.to_s
  value
end

def find_loop_size(key)
  value = 1
  loop_size = 0

  while value != key do
    loop_size += 1
    value = (value * 7).remainder(SALT)
  end
  loop_size
end

def star_1
  card_loop_size = find_loop_size(CARD_PUBLIC_KEY)
  door_loop_size = find_loop_size(DOOR_PUBLIC_KEY)
  p "Encryption key is the same #{[calculate_encryption_key(CARD_PUBLIC_KEY, door_loop_size), calculate_encryption_key(DOOR_PUBLIC_KEY, card_loop_size)]}"
end

def star_2
end

star_1
star_2

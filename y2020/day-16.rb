#!/usr/bin/env ruby

RULES = {
  'departure_location' => -> (value) { (27..180).cover?(value) || (187..953).cover?(value) },
  'departure_station' => -> (value) { (47..527).cover?(value) || (545..958).cover?(value) },
  'departure_platform' => -> (value) { (36..566).cover?(value) || (572..973).cover?(value) },
  'departure_track' => -> (value) { (37..497).cover?(value) || (505..971).cover?(value) },
  'departure_date' => -> (value) { (47..707).cover?(value) || (719..969).cover?(value) },
  'departure_time' => -> (value) { (36..275).cover?(value) || (290..949).cover?(value) },
  'arrival_location' => -> (value) { (31..855).cover?(value) || (864..955).cover?(value) },
  'arrival_station' => -> (value) { (50..148).cover?(value) || (158..949).cover?(value) },
  'arrival_platform' => -> (value) { (50..441).cover?(value) || (467..965).cover?(value) },
  'arrival_track' => -> (value) { (30..648).cover?(value) || (659..962).cover?(value) },
  'class' => -> (value) { (26..470).cover?(value) || (481..966).cover?(value) },
  'duration' => -> (value) { (27..808).cover?(value) || (818..958).cover?(value) },
  'price' => -> (value) { (49..769).cover?(value) || (784..970).cover?(value) },
  'route' => -> (value) { (49..796).cover?(value) || (809..964).cover?(value) },
  'row' => -> (value) { (42..362).cover?(value) || (383..971).cover?(value) },
  'seat' => -> (value) { (34..877).cover?(value) || (887..952).cover?(value) },
  'train' => -> (value) { (31..354).cover?(value) || (363..950).cover?(value) },
  'type' => -> (value) { (39..208).cover?(value) || (231..953).cover?(value) },
  'wagon' => -> (value) { (47..736).cover?(value) || (746..968).cover?(value) },
  'zone' => -> (value) { (44..290).cover?(value) || (310..974).cover?(value) }
}
TICKET = [97,61,53,101,131,163,79,103,67,127,71,109,89,107,83,73,113,59,137,139]
tickets = nil

File.read('input/day-16.txt').lines(chomp: true).each do |line|
  tickets << line.split(',').map {|n| n.to_i} if tickets
  tickets = [] if line == 'nearby tickets:'
end
TICKETS = tickets

def not_valid?(value)
  RULES.each do |rule|
    return false if rule.last.(value)
  end
  true
end

def star_1
  sum = 0
  TICKETS.each {|tn| tn.each {|n| sum += n if not_valid?(n)}}
  p "Ticket scanning error rate is #{sum}"
end

def get_valid_tickets(tickets)
  TICKETS - tickets.select {|tn| tn.select {|n| not_valid?(n)}.any?}
end

def transform_tickets(tickets)
  length = tickets.last.length
  transformed = []
  (0...length).each do |index|
    transformed[index] = []
    tickets.each do |ticket|
      transformed[index] << ticket.shift
    end
  end
  transformed
end

def check(tickets, rule, index)
   tickets.map {|ticket| RULES[rule].(ticket[index]) }
  true
end

def star_2
  tickets = get_valid_tickets(TICKETS)
  transformed = transform_tickets(tickets)

  rules = {}
  transformed.each_with_index do |numbers, index|
    rules[index] = []
    RULES.keys.each do |rule|
      if numbers.map {|n| RULES[rule].(n) }.all?
        rules[index] << rule
      end
      rules[index].sort!
    end
  end

  fixed = Array.new(rules.keys.length)
  (1..rules.keys.length).each do |length|
    rule = rules.select {|k,v| v.length == length}
    key, values = rule.first
    fixed[key] = (values-fixed.compact).first
  end

  multiplier = 1
  keys = ['departure_location', 'departure_station', 'departure_platform', 'departure_track', 'departure_date', 'departure_time']
  fixed.each_with_index do |rule, index|
    if keys.include?(rule)
      multiplier *= TICKET[index]
    end
  end
  p "My multiplier is #{multiplier}"
end

star_1
star_2

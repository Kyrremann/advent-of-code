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
TICKETS = nil

File.read('input/day-16.txt').lines(chomp: true).each do |line|
  TICKETS << line.split(',').map {|n| n.to_i} if TICKETS
  TICKETS = [] if line == 'nearby tickets:'
end

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

def star_2
end

star_1
star_2

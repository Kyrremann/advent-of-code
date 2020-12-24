#!/usr/bin/env ruby

INPUT = []
File.readlines('input/day-24.txt').each do |line|
  INPUT << line.chomp
end

TEST_INPUT = %w(sesenwnenenewseeswwswswwnenewsewsw
neeenesenwnwwswnenewnwwsewnenwseswesw
seswneswswsenwwnwse
nwnwneseeswswnenewneswwnewseswneseene
swweswneswnenwsewnwneneseenw
eesenwseswswnenwswnwnwsewwnwsene
sewnenenenesenwsewnenwwwse
wenwwweseeeweswwwnwwe
wsweesenenewnwwnwsenewsenwwsesesenwne
neeswseenwwswnwswswnw
nenwswwsewswnenenewsenwsenwnesesenew
enewnwewneswsewnwswenweswnenwsenwsw
sweneswneswneneenwnewenewwneswswnese
swwesenesewenwneswnwwneseswwne
enesenwswwswneneswsenwnewswseenwsese
wnwnesenesenenwwnenwsewesewsesesew
nenewswnwewswnenesenwnesewesw
eneswnwswnwsenenwnwnwwseeswneewsenese
neswnwewnwnwseenwseesewsenwsweewe
wseweeenwnesenwwwswnew)

COORDS = {"e" => [+1,0], "se" => [0,+1], "sw" => [-1,+1], "w" => [-1,0], "nw" => [0,-1], "ne" => [+1,-1]}
def move_to(steps)
  person = [0,0]
  steps = steps.chars
  while steps.any?
    d = steps.shift
    d += steps.shift if d =~ /[sn]/
    person[0] += COORDS[d][0]
    person[1] += COORDS[d][1]
  end
  person
end

def count_black_tiles(input)
  map = Hash.new(0)
  input.map {|cords| move_to(cords)}.each {|m| map[m] += 1}
  map.values.count{ |x| x%2!=0 }
end

def star_1
  p "There should be 10 black tiles: #{count_black_tiles(TEST_INPUT) == 10}"
  p "There are #{count_black_tiles(INPUT)} black tiles"
end

def star_2
end

star_1
star_2

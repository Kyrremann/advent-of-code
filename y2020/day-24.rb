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

BLACK = 1
WHITE = 0
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

def black?(n)
  n == BLACK
end

def get_movements(input)
  map = Hash.new(0)
  input.map {|cords| move_to(cords)}.each {|k| map[k] = black?(map[k]) ? WHITE : BLACK }
  map
end

def count_black_tiles(map)
  map.values.count{ |x| black?(x) }
end

def star_1
  p "There should be 10 black tiles: #{count_black_tiles(get_movements(TEST_INPUT)) == 10}"
  p "There are #{count_black_tiles(get_movements(INPUT))} black tiles"
end

def add_surrounding_tiles(tiles)
  tiles.each do |coord,v|
    COORDS.values.each {|c| tiles[[coord[0]+c[0], coord[1]+c[1]]] ||= 0 }
  end
end

def count_surrounding_black_tiles(tiles, coord)
  COORDS.values.count {|v| black?(tiles[[coord[0]+v[0], coord[1]+v[1]]])}
end

def flip_tile(tiles, tmp, tile)
  blacks = count_surrounding_black_tiles(tmp, tile)
  if black?(tmp[tile])
    tiles[tile] = WHITE if blacks == 0 || blacks > 2
  else
    tiles[tile] = BLACK if blacks == 2
  end
end

def flip(tiles)
  tmp = tiles.clone
  tmp.each do |tile, color|
    coords = COORDS.map {|k,c| [tile[0]+c[0], tile[1]+c[1]]}.append(tile)
    coords.each {|coord| flip_tile(tiles, tmp, coord)}
  end
  tiles
end

def star_2
  tiles = get_movements(TEST_INPUT)
  100.times {|i| tiles = flip(tiles)}
  p "After 100 times there are #{count_black_tiles(tiles)} black tiles"

  tiles = get_movements(INPUT)
  100.times {|i| tiles = flip(tiles)}
  p "After 100 times there are #{count_black_tiles(tiles)} black tiles"
end

star_1
star_2

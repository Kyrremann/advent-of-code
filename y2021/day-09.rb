INPUT = []
File.readlines('input/day-09.txt').each do |line|
  INPUT << line.chomp
end


test = ['2199943210',
        '3987894921',
        '9856789892',
        '8767896789',
        '9899965678']

def around(input, x, y)
  values = []

  values << [x+1, y] if x+1 < input[y].size
  values << [x, y+1] if y+1 < input.size
  values << [x-1, y] if x > 0
  values << [x, y-1] if y > 0
  values
end

def around_depth(input, x, y)
  around(input, x, y).map {|loc| x,y = loc; input[y][x].to_i}
end

def basin(input)
  locations = []
  input.each_with_index do |row, y|
    row.chars.each_with_index do |column, x|
      values = around_depth(input, x, y)
      locations << [x,y] if values.all? {|n| n > column.to_i }
    end
  end

  locations
end

def star1(input)
  basin(input).map {|loc| x,y = loc; input[y][x].to_i}.sum {|n| n+1}
end

p "TEST: Risk level: #{star1(test)}"
p "Risk level: #{star1(INPUT)}"

def explore(input, x, y)
  basin = input[y][x].to_i
  locations = around(input, x, y)
  new_locations = locations.select {|loc| _x,_y = loc; depth = input[_y][_x].to_i; depth > basin && depth < 9}
  [[x,y]] + new_locations.map {|loc| explore(input, *loc)}.flatten(1)
end  

def star2(input)
  bottom = basin(input)
  bottom.map {|loc| explore(input, *loc).uniq.count}.max(3).inject(:*)
end

p "TEST: Basin size: #{star2(test)}"
p "Basin size: #{star2(INPUT)}"

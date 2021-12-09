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

  values << input[y-1][x] if y > 0
  values << input[y][x+1] if x+1 < input[y].size
  values << input[y][x-1] if x > 0
  values << input[y+1][x] if y+1 < input.size
  values
end

def explore(input)
  locations = []
  input.each_with_index do |row, y|
    row.chars.each_with_index do |column, x|
      values = around(input, x, y)
      locations << [x,y] if values.all? {|n| n > column }
    end
  end

  locations
end

def star1(input)
  explore(input).map {|loc| x,y = loc; input[y][x].to_i}.sum {|n| n+1}
end

p star1(test)
p star1(INPUT)

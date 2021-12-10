INPUT = []
File.readlines('input/day-05.txt').each do |line|
  INPUT << line.chomp
end

test = ['0,9 -> 5,9',
        '8,0 -> 0,8',
        '9,4 -> 3,4',
        '2,2 -> 2,1',
        '7,0 -> 7,4',
        '6,4 -> 2,0',
        '0,9 -> 2,9',
        '3,4 -> 1,4',
        '0,0 -> 8,8',
        '5,5 -> 8,2']

def star1(input)
  lines = input.map{|line| line.split(' -> ')}
            .map{|n| n.map{|n| n.split(',').map{|s| s.to_i}}.sort}
            .select{|segment|  a,b = segment; a[0] == b[0] || a[-1] == b[-1]}

  points = []
  lines.each do |range|
    a,b = range
    if a[0] == b[0]
      points << a.join(',')
      (a[1].next...b[1]).each {|n| points << "#{a[0]},#{n}" }
      points << b.join(',')
    else
      points << a.join(',')
      (a[0].next...b[0]).each {|n| points << "#{n},#{a[1]}" }
      points << b.join(',')
    end
  end

  points.tally.count {|k,v| v > 1}
end

p "TEST: Lines overlap #{star1(test)} times"
p "Lines overlap #{star1(INPUT)} times"

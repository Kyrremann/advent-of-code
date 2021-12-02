COURSE = []
File.readlines('input/day-02.txt').each do |line|
  COURSE << line.chomp
end

def star1(course)
  z = 0
  y = 0
  course.each do |c|
    action, mod = c.split
    mod = mod.to_i
    case action
    when 'up'
      y -= mod
    when 'down'
      y += mod
    when 'forward'
      z += mod
    end
  end

  z * y
end

test = [ 'forward 5',
         'down 5',
         'forward 8',
         'up 3',
         'down 8',
         'forward 2']
p "TEST: Multipling the final horizontal position by the final depth: #{star1(test)}"
p "Multipling the final horizontal position by the final depth: #{star1(COURSE)}"



def star2(course)
  z = 0
  y = 0
  aim = 0
  course.each do |c|
    action, mod = c.split
    mod = mod.to_i
    case action
    when 'up'
      aim -= mod
    when 'down'
      aim += mod
    when 'forward'
      z += mod
      y += mod*aim
    end
  end

  z * y
end

p "TEST: Multipling the final horizontal position by the final depth: #{star2(test)}"
p "Multipling the final horizontal position by the final depth: #{star2(COURSE)}"

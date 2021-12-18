test = [(20..30), (-10..-5)]
INPUT = [(85..145), (-163..-108)]

def gauss(n)
  ((n**2)+n)/2
end

def calculate_x(range)
  start = 1
  while !range.include?(gauss(start)) do
    start += 1
  end
  start
end

def calculate_y(range)
  (range.min.abs - 1)
end

def star1(targetX, targetY)
  x = calculate_x(targetX)
  y = calculate_y(targetY)
  gauss(y)
end

p "TEST: highest y position: #{star1(*test)}"
p "highest y position: #{star1(*INPUT)}"

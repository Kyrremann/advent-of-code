test = [(20..30), (-10..-5)]
INPUT = [(85..145), (-163..-108)]

def gauss(n)
  ((n**2)+n)/2
end

def star1(targetX, targetY)
  gauss(targetY.min.abs - 1)
end

p "TEST: highest y position: #{star1(*test)}"
p "highest y position: #{star1(*INPUT)}"

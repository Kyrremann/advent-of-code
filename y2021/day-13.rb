INPUT = []
File.readlines('input/day-13.txt').each do |line|
  x,y = line.chomp.split(',')
  INPUT << [x.to_i, y.to_i]
end

FOLDS = ['x=655',
         'y=447',
         'x=327',
         'y=223',
         'x=163',
         'y=111',
         'x=81',
         'y=55',
         'x=40',
         'y=27',
         'y=13',
         'y=6']

test = [[6,10],
        [0,14],
        [9,10],
        [0,3],
        [10,4],
        [4,11],
        [6,0],
        [6,12],
        [4,1],
        [0,13],
        [10,12],
        [3,4],
        [3,0],
        [8,4],
        [1,10],
        [2,14],
        [8,10],
        [9,0]]

def fold(input, foldX, foldY)
  input.map do |point|
    x,y = point
    y = foldY - (y - foldY) if foldY && y >= foldY
    x = foldX - (x - foldX) if foldX && x >= foldX
    [x,y]
  end
end

def star1(input, foldX, foldY)
  fold(input, foldX, foldY).sort.uniq.size
end

p star1(test, nil, 7)
p star1(INPUT, FOLDS[0].split('=')[1].to_i, nil)

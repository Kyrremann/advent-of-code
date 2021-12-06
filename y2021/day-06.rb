INPUT = [1,1,1,2,1,1,2,1,1,1,5,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,4,1,1,1,1,3,1,1,3,1,1,1,4,1,5,1,3,1,1,1,1,1,5,1,1,1,1,1,5,5,2,5,1,1,2,1,1,1,1,3,4,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,5,4,1,1,1,1,1,5,1,2,4,1,1,1,1,1,3,3,2,1,1,4,1,1,5,5,1,1,1,1,1,2,5,1,4,1,1,1,1,1,1,2,1,1,5,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,3,1,1,3,1,3,1,4,1,5,4,1,1,2,1,1,5,1,1,1,1,1,5,1,1,1,1,1,1,1,1,1,4,1,1,4,1,1,1,1,1,1,1,5,4,1,2,1,1,1,1,1,1,1,1,1,1,1,3,1,1,1,1,1,1,1,1,1,1,4,1,1,1,2,1,4,1,1,1,1,1,1,1,1,1,4,2,1,2,1,1,4,1,1,1,1,1,1,3,1,1,1,1,1,1,1,1,3,2,1,4,1,5,1,1,1,4,5,1,1,1,1,1,1,5,1,1,5,1,2,1,1,2,4,1,1,2,1,5,5,3]
test = [3,4,3,1,2]

def star1(fish)
  (0...80).each do |day|
    fish = fish.map {|f| f-1}
    count = fish.count {|f| f==-1}
    fish = fish.map {|f| f==-1 ? 6 : f}
    fish.concat([8] * count)
  end

  fish.count
end

p "TEST: After 80 days there are #{star1(test)} lanternfish"
p "After 80 days there are #{star1(INPUT)} lanternfish"

def star2(fish)
  days = {0=>0,1=>0,2=>0,3=>0,4=>0,5=>0,6=>0,7=>0,8=>0}
  fish.each {|f| days[f] += 1}
  p days
  (0...256).each do |day|
    tmp = days.values
    for i in 8.downto(0) do
      if i == 0
        days[6] += tmp[i]
        days[8] = tmp[i]
      else
        days[i-1] = tmp[i]
      end
    end
  end

  days.values.sum
end

p "TEST: After 256 days there are #{star2(test)} lanternfish"
p "After 256 days there are #{star2(INPUT)} lanternfish"

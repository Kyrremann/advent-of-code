test = [4, 8]
INPUT = [6, 8]

def move(start, space)
  score = 0
  start.step(10000, 6).each do |n|
    sum = n + (n+1) + (n+2)
    space += sum
    space = space % 10 if space > 10
    score += space
    break if score > 1000
  end

  score
end

def star1(a, b)
  rolledDice = 0
  firstPlayer = true
  playerA = 0
  playerB = 0

  (1..100).cycle.each_slice(3) do |dice|
    rolledDice += 3
    sum = dice.sum
    if firstPlayer
      a += sum
      a = a % 10 if a > 10
      a = 10 if a == 0
      playerA += a
      # p "Player A rolls #{dice} and moves to space #{a} for a total score of #{playerA}."
    else
      b += sum
      b = b % 10 if b > 10
      b = 10 if b == 0
      playerB += b
      # p "Player B rolls #{dice} and moves to space #{b} for a total score of #{playerB}."
    end

    break if playerA >= 1000 || playerB >= 1000

    firstPlayer = !firstPlayer
  end

  return rolledDice * [playerA, playerB].min
end

p "TEST: The score: #{star1(*test)}"
p "The score: #{star1(*INPUT)}"

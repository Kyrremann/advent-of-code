INPUT = []
File.readlines('input/day-03.txt').each do |line|
  INPUT << line.chomp.chars
end

test = ['00100'.chars,
        '11110'.chars, 
        '10110'.chars, 
        '10111'.chars, 
        '10101'.chars, 
        '01111'.chars, 
        '00111'.chars, 
        '11100'.chars, 
        '10000'.chars, 
        '11001'.chars, 
        '00010'.chars, 
        '01010'.chars]

def star1(report)
  gamma = report.transpose.map{ |a| a.join }.map{ |s| s.count('1') > s.count('0') ? 1 : 0 }.join
  epsilon = gamma.chars.map{|i| i == "1" ? "0" : "1" }.join
  gamma.to_i(2) * epsilon.to_i(2)
end

p "Power consumption: #{star1(test)}"
p "Power consumption: #{star1(INPUT)}"

def analyzer(report, value)
  size = report[0].size
  (0...size).each do |i|
    collect = []
    report.each do |r|
      collect << r[i]
    end
    break if collect.size == 1
    tallied = collect.tally
    if tallied.values.uniq.size == 1
      common = value
    else
      if value == "1"
        common = tallied.invert.max.last
      else
        common = tallied.invert.min.last
      end
    end

    report = report.select {|s| s[i] == common }
  end

  return report.join.to_i(2)
end

def star2(report)
  analyzer(report, "1") * analyzer(report, "0")
end

p "The life support rating of the submarine: #{star2(test)}"
p "The life support rating of the submarine: #{star2(INPUT)}"

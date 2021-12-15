TEMPLATE = 'FNFPPNKPPHSOKFFHOFOC'
INSERTIONS = {}
File.readlines('input/day-14.txt').each do |line|
  pair, insert = line.chomp.split(' -> ')
  INSERTIONS[pair] = insert
end

test_template = 'NNCB'
test_insertions = {'CH' => 'B',
                   'HH' => 'N',
                   'CB' => 'H',
                   'NH' => 'C',
                   'HB' => 'C',
                   'HC' => 'B',
                   'HN' => 'C',
                   'NN' => 'C',
                   'BH' => 'H',
                   'NC' => 'B',
                   'NB' => 'B',
                   'BN' => 'B',
                   'BB' => 'N',
                   'BC' => 'B',
                   'CC' => 'N',
                   'CN' => 'C'}

def polymerization(steps, template, insertions)
  polymer = template
  (1..steps).each do |step|
    tmp = ""
    for i in 0...polymer.size-1 do
      a = polymer[i]
      b = polymer[i+1]
      insert = insertions[a+b]
      #print a+b, "=", insert, "\n"
      tmp += a + insert if insert
      tmp += a unless insert
    end
    tmp += polymer[-1]
    polymer = tmp
    #p "#{step}: #{polymer} (#{polymer.size})"
  end

  polymers = polymer.chars.tally.sort_by{|k,v| v}
  min = polymers.first.last
  max = polymers.last.last
  max - min
end

def star1(template, insertions)
  polymerization(10, template, insertions)
end

p "TEST: Polymer substraciton score: #{star1(test_template, test_insertions)}"
p "Polymer substraction score: #{star1(TEMPLATE, INSERTIONS)}"

#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = 'x00: 1
x01: 1
x02: 1
y00: 0
y01: 1
y02: 0

x00 AND y00 -> z00
x01 XOR y01 -> z01
x02 OR y02 -> z02'

test_big = 'x00: 1
x01: 0
x02: 1
x03: 1
x04: 0
y00: 1
y01: 1
y02: 1
y03: 1
y04: 1

ntg XOR fgs -> mjb
y02 OR x01 -> tnw
kwq OR kpj -> z05
x00 OR x03 -> fst
tgd XOR rvg -> z01
vdt OR tnw -> bfw
bfw AND frj -> z10
ffh OR nrd -> bqk
y00 AND y03 -> djm
y03 OR y00 -> psh
bqk OR frj -> z08
tnw OR fst -> frj
gnj AND tgd -> z11
bfw XOR mjb -> z00
x03 OR x00 -> vdt
gnj AND wpb -> z02
x04 AND y00 -> kjc
djm OR pbm -> qhw
nrd AND vdt -> hwm
kjc AND fst -> rvg
y04 OR y02 -> fgs
y01 AND x02 -> pbm
ntg OR kjc -> kwq
psh XOR fgs -> tgd
qhw XOR tgd -> z09
pbm OR djm -> kpj
x03 XOR y03 -> ffh
x00 XOR y04 -> ntg
bfw OR bqk -> z06
nrd XOR fgs -> wpb
frj XOR qhw -> z04
bqk OR frj -> z07
y03 OR x01 -> nrd
hwm AND bqk -> z03
tgd XOR rvg -> z12
tnw OR pbm -> gnj'

def simulate(wires, gate, debug = false)
  a, op, b, _, output = gate

  # p  wires[a] && wires[b]
  # print a, '[', wires[a], '] ', op, ' ', b, '[', wires[b], ']', "\n" if debug
  return false unless wires[a] && wires[b]

  value = case op
          when 'AND'
            wires[a] == 1 && wires[b] == 1 ? 1 : 0
          when 'OR'
            wires[a] == 1 || wires[b] == 1 ? 1 : 0
          when 'XOR'
            wires[a] == wires[b] ? 0 : 1
          end

  print a, '[', wires[a], '] ', op, ' ', b, '[', wires[b], '] = ', value, "\n" if debug
  wires[output] = value

  true
end

def format(input)
  init_wires, gates = input.split("\n\n")
  wires = {}
  init_wires.split("\n").each do |w|
    k, v = w.split(': ')
    wires[k] = v.to_i
  end

  [wires, gates.split("\n").map(&:split)]
end

def star1(input, debug = false)
  wires, gates = format(input)

  p wires, gates if debug

  until gates.empty?
    gate = gates.pop
    gates.prepend(gate) unless simulate(wires, gate, debug)
  end

  p wires.select { |k, v| k.start_with?('z') }.sort.map(&:last).join.reverse if debug
  wires.select { |k, v| k.start_with?('z') }.sort.map(&:last).join.reverse.to_i(2)
end

debug = false
p "Test: #{star1(test_input, debug)} == 4"
p "Test: #{star1(test_big, debug)} == 2024"
p "Star 1: #{star1(INPUT)}"

test_input = 'x00: 0
x01: 1
x02: 0
x03: 1
x04: 0
x05: 1
y00: 0
y01: 0
y02: 1
y03: 1
y04: 0
y05: 1

x00 AND y00 -> z05
x01 AND y01 -> z02
x02 AND y02 -> z01
x03 AND y03 -> z03
x04 AND y04 -> z04
x05 AND y05 -> z00'

def star2(input, debug = false)
  _, gates = input.split("\n\n")
  operations = {}
  gates = gates.split("\n").map { |gate| gate.split(' -> ') }
  gates.each { |gate, output| operations[output] = gate }
  operations = operations.sort.to_h

  # gates.each do |input, output|
  #   a, op, b = input.split
  #   next unless output.start_with?('z')
  #
  #   print a, '(', operations[a], ') ', op, ' ', b, '(', operations[b], ') = ', output, "\n"
  # end

  def txt(operations, gate)
    if gate.start_with?('x') || gate.start_with?('y')
      print gate
    else
      a, op, b = gate.split
      txt(operations, operations[a])
      print ' ', op, "\n "
      txt(operations, operations[b])
    end
  end

  operations.each do |key, gate|
    # print key, ' -> ', gate, "\n"
    next unless key.start_with?('z')

    print key, ' -> '
    txt(operations, gate)
    print "\n\n"
    # if gate.start_with?('x') || gate.start_with?('y')
    #   print gate, "\n"
    #   next
    # else
    #   a, op, b = gate.split
    #
    #   # print operations[a], ' ', op, ' ', operations[b], "\n"
    # end

    next

    def some(operations, key, a, op, b)
      if a.start_with?('x') || a.start_with?('y')
        p a, b
        operations[key] = "(#{operations[a]} #{op} #{operations[b]})"
      else
        print 'go deeper, ', a, ' ', op, ' ', b, "\n"

        aa, aop, ab = operations[a].split
        some(operations, a, aa, aop, ab)

        ba, bop, bb = operations[b].split
        some(operations, a, ba, bop, bb)
      end
    end

    a, op, b = gate.split
    some(operations, key, a, op, b)
  end

  0
end

p "Test: #{star2(test_input, false)} == z00,z01,z02,z05" if false
p "Star 2: #{star2(INPUT)}"

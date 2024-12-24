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

def star1(input, debug = false)
  init_wires, gates = input.split("\n\n")
  wires = {}
  init_wires.split("\n").each do |w|
    k, v = w.split(': ')
    wires[k] = v.to_i
  end
  gates = gates.split("\n").map(&:split)

  p wires, gates if debug

  until gates.empty?
    gate = gates.pop
    gates.prepend(gate) unless simulate(wires, gate, debug)
  end

  p wires.select { |k, v| k.start_with?('z') }.sort.map(&:last).join.reverse if debug
  wires.select { |k, v| k.start_with?('z') }.sort.map(&:last).join.reverse.to_i(2)
end

p "Test: #{star1(test_input, true)} == 4"
p "Test: #{star1(test_big, true)} == 2024"
p "Star 1: #{star1(INPUT)}"

# def star2(input, debug = false)
# end

# p "Test: #{star2(test_input, true)} == 23"
# p "Star 2: #{star2(INPUT)}"

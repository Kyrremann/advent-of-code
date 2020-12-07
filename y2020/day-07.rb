#!/usr/bin/env ruby

INPUT = []
File.readlines('input/day-07.txt').each do |line|
  INPUT << line.chomp
end

def contains_at_least_a_shiny_bag(input)
  bags = ['shiny gold']
  added = true
  while added do
    added = false
    input.each do |line|
      m = line.match(/(.*)\sbags\scontain\s(.*)\./)
      if m && m[2]
        contains = []
        m[2].split(', ').map do |b|
          o = b.match(/(\d)\s(.*)/)
          contains << o[2].sub(/ bags?/, '') if o
        end

        unless (bags & contains).empty?
          name = m[1]
          unless bags.include?(name)
            added = true
            bags << name
          end
        end
      end
    end
  end

  bags.delete('shiny gold')
  bags
end

def star_1
  test_input = '''light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.'''.split("\n")
  p contains_at_least_a_shiny_bag(test_input).size == 4

  p "There are #{contains_at_least_a_shiny_bag(INPUT).size} bags tht can eventually contain at least one shiny gold bag"
end

class Node
  attr_reader :name, :children
  def initialize(name)
    @name = name
    @children = []
  end

  def concat(children)
    @children = @children.append(children)
  end
end

def loopish(input, node)
  children = []
  input.each do |line|
    m = line.match(/(.*)\sbags\scontain\s(.*)\./)
    name = m[1]
    if name == node.name
      bags = m[2]
      if bags == 'no other bags'
        return children, 0
      else
        m[2].split(', ').each do |b|
          o = b.match(/(\d)\s(.*)/)
          o[1].to_i.times { children << Node.new(o[2].sub(/ bags?/, '')) }
        end
      end
    end
  end

  size = 0
  children.each do |child|
    c, s = loopish(input, child)
    size += s
    node.concat(c)
  end

  return children, (children.size + size)
end

def star_2
  test_input = '''shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags.'''.split("\n")
  root = Node.new('shiny gold')
  children, size = loopish(test_input, root)
  root.concat(children)
  p size == 126
  
  root = Node.new('shiny gold')
  children, size = loopish(INPUT, root)
  root.concat(children)
  p "#{size} individual bags are required inside my single shiny gold bag"
end

star_1
star_2

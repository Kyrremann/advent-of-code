#!/usr/bin/env ruby
# frozen_string_literal: true

input_file = "input/#{File.basename(__FILE__).match(/\d\d?/)[0]}"

INPUT = File.read(input_file) if File.exist?(input_file)

test_input = 'RRRRIICCFF
RRRRIICCCF
VVRRRCCFFF
VVRCCCJFFF
VVVVCJJCFE
VVIVCCJJEE
VVIIICJJEE
MIIIIIJJEE
MIIISIJEEE
MMMISSJEEE'

test_input_1 = 'AAAA
BBCD
BBCC
EEEC'

test_input_2 = 'OOOOO
OXOXO
OOOOO
OXOXO
OOOOO'

test_input_3 = 'OXO
XXO
OOO'

class Region
  def initialize(y, x, debug = false)
    @debug = debug
    @regions = [[[y, x]]]
  end

  def expand(y, x)
    print '(', y, ',', x, ") is added\n" if @debug
    @regions.each_with_index { |plot, index| return @regions[index] << [y, x] if same_plot?(plot, y, x) }

    puts 'to a new plot' if @debug
    @regions << [[y, x]]
  end

  def total_price
    @regions.sum { |region| price(region) }
  end

  def merge
    return if @regions.size == 1

    @regions.each_with_index do |region, i|
      region.each do |y, x|
        output = (i + 1...@regions.length).select do |ii|
          @regions[ii].any? do |yy, xx|
            print y, ',', x, ' connected ', yy, ',', xx if @debug && connected?(y, x, yy, xx)
            break true if connected?(y, x, yy, xx)

            false
          end
        end

        next if output.empty?

        output.each do |ii|
          @regions[ii]
        end

        output.each do |ii|
          @regions[i] += @regions[ii]
        end

        output.each do |ii|
          @regions.delete_at(ii)
        end

        return merge
      end
    end
  end

  def to_s
    map = @regions.map { |a| a.to_s + ' => ' + price(a).to_s }.join("\n\t")
    "#{total_price}\n\t#{map}"
  end

  private

  def price(region)
    area = region.count
    perimeter = region.sum { |y, x| 4 - region.count { |yy, xx| connected?(y, x, yy, xx) } }

    area * perimeter
  end

  def connected?(y, x, yy, xx)
    (yy == y && (xx + 1 == x || xx - 1 == x)) || (xx == x && (yy + 1 == y || yy - 1 == y))
  end

  def same_plot?(plot, y, x)
    plot.each do |yy, xx|
      return true if connected?(y, x, yy, xx)
    end

    false
  end
end

class Farm
  def initialize(debug = false)
    @debug = debug
    @regions = {}
  end

  def expand(plot, y, x)
    return @regions[plot].expand(y, x) if @regions.include?(plot)

    puts ' is new' if @debug
    @regions[plot] = Region.new(y, x, @debug)
  end

  def merge
    @regions.each do |plot, region|
      p plot if @debug
      region.merge
    end
  end

  def total_price
    @regions.sum do |plot, regions|
      regions.total_price
    end
  end

  def inspect
    @regions.map { |key, regions| "#{key}: #{regions}" }.join("\n")
  end
end

def star1(input, debug = false)
  input = input.split("\n")
  farm = Farm.new(debug)
  (0...input.length).each do |y|
    (0...input[y].length).each do |x|
      plot = input[y][x]

      farm.expand(plot, y, x)
    end
  end

  farm.merge

  p farm if debug
  farm.total_price
end

debug = false
p "Test 1: #{star1(test_input_1, debug)} == 140"
p "Test 2: #{star1(test_input_2, debug)} == 772"
p "Test 2: #{star1(test_input_3, debug)} == 772"
p "Test full: #{star1(test_input, debug)} == 1930"
p "Star 1: #{star1(INPUT)}"

# def star2(input, debug = false)
# end
#
# p "Test: #{star2(test_input, true)} == x"
# p "Star 2: #{star2(INPUT)}"

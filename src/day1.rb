# frozen_string_literal: true

# Load input
modules = File.readlines('res/day1.txt')
              .reject { |l| l.strip.empty? }
              .map(&:to_i)

# Part 1
p modules.map { |v| v / 3 - 2 }.sum

# Part 2
fuel_calc = lambda do |fuel|
  if fuel <= 0
    0
  else
    partial = fuel / 3 - 2
    fuel + fuel_calc.call(partial)
  end
end

p modules.map { |v| fuel_calc.call(v) - v }.sum

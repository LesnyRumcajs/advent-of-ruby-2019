# Load input
modules = File.readlines('res/day1.txt').select { |l| !l.strip.empty? }.map(&:to_i)

# Part 1
p modules.map { |v| v / 3  - 2}.sum

# Part 2
fuel_calc = -> (fuel) do
  if fuel <= 0
    0
  else
    partial = fuel / 3 - 2
    fuel + fuel_calc.(partial)
  end
end

p modules.map { |v| fuel_calc.(v) - v}.sum

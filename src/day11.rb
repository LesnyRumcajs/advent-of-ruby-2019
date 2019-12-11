# frozen_string_literal: true

require_relative 'components/intcodeparser'

def run_robot(panels)
  program = File.read('res/day11.txt').split(',').map(&:to_i)
  orientation = Math::PI / 2
  pos = [0, 0]

  computer = IntCodeParser.new program
  until computer.finished?
    input = [panels[pos]]
    color = computer.calculate input
    rotation = computer.calculate input

    break if computer.finished?

    panels[pos] = color
    orientation += Math::PI / 2 - Math::PI * rotation
    pos = [pos[0] + Math.sin(orientation).round(0),
           pos[1] + Math.cos(orientation).round(0)]
  end
end

# part 1
panels = Hash.new(0)
run_robot(panels)
p panels.count

# part 2
panels = Hash.new(0)
panels[[0, 0]] = 1
run_robot(panels)

min_y, max_y = panels.minmax_by { |k, _| k[0] }.map { |y| y[0][0] }
min_x, max_x = panels.minmax_by { |k, _| k[1] }.map { |x| x[0][1] }

identifier = Array.new(max_y - min_y + 1) { Array.new(max_x - min_x + 1, ' ') }
panels.map { |k, v| [[k[0] - min_y, k[1] - min_x], v] }.each do |k, v|
  identifier[k[0]][k[1]] = v.zero? ? ' ' : '■'
end

puts identifier.map(&:join).reverse

# frozen_string_literal: true
require_relative 'components/intcodeparser'

# load data
data_orig = File.read('res/day7.txt').split(',').map(&:to_i)

# part 1
max_power = 0
(0..4).to_a.permutation(5).each do |seq|
  out = 0
  seq.each do |v|
    program = IntCodeParser.new(data_orig.clone)
    input = [v, out]
    until program.finished?
      out = program.calculate(input)
    end
  end
  max_power = [max_power, out].max
end
p max_power

# part 2
max_power = 0
(5..9).to_a.permutation(5).each do |seq|
  out = 0
  amps = (1..5).map {|| IntCodeParser.new(data_orig.clone) }
  amps_inputs = seq.map {|s| [s]}

  until amps.all?(&:finished?)
    (0..4).each do |i|
      out = amps[i].calculate(amps_inputs[i] << out)
    end
  end
  max_power = [max_power, out].max
end
p max_power

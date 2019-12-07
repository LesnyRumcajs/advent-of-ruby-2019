# frozen_string_literal: true
require_relative 'components/intcodeparser'

# load data
intcode = File.read('res/day5.txt').split(',').map(&:to_i)

# part 1
computer = IntCodeParser.new(intcode.clone)
computer.calculate [1] until computer.finished?
p computer.output

# part 2
computer = IntCodeParser.new(intcode.clone)
computer.calculate [5] until computer.finished?
p computer.output

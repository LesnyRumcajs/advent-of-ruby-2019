require_relative 'components/intcodeparser'

intcode = File.read('res/day9.txt').split(',').map(&:to_i)

# part 1
computer = IntCodeParser.new(intcode.clone)
computer.calculate [1] until computer.finished?
p computer.output

# part 2
computer = IntCodeParser.new(intcode.clone)
computer.calculate [2] until computer.finished?
p computer.output

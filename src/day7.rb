
# frozen_string_literal: true

class IntCodeParser
  def initialize(code)
    @data = code
    @ip = 0
    @finished = false
    @output = 0
  end

  def finished?
    @finished || @ip >= @data.size
  end

  def calculate(input)
    while @ip < @data.size
      header = ("%04d" % @data[@ip]).chars
      opcode = header[-2..-1].join.to_i
      modes = header[0..-3].reverse.map(&:to_i)
      case opcode
      when 99
        @finished = true
        break
      when 1
        x = get_value(modes, 1)
        y = get_value(modes, 2)

        @data[@data[@ip + 3]] = x + y
        @ip += 4
      when 2
        x = get_value(modes,1)
        y = get_value(modes,2)

        @data[@data[@ip + 3]] = x * y
        @ip += 4
      when 3
        @data[@data[@ip + 1]] = input.shift
        @ip += 2
      when 4
        @output = get_value(modes,1)
        @ip += 2
        break
      when 5
        @ip =  get_value(modes,1) != 0 ? get_value(modes,2) : @ip + 3
      when 6
        @ip =  get_value(modes,1) == 0 ? get_value(modes,2) : @ip + 3
      when 7
        @data[get_value(modes,3)] = get_value(modes,1) < get_value(modes,2) ? 1 : 0
        @ip += 4
      when 8
        @data[get_value(modes,3)] = get_value(modes,1) == get_value(modes,2) ? 1 : 0
        @ip += 4
      else
        throw 'Fiasco'
      end
    end

    @output
  end

  private

  def get_value(modes, param_nr)
    modes[param_nr - 1] != 0 ? @data[@ip + param_nr] : @data[@data[@ip + param_nr]]
  end
end

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

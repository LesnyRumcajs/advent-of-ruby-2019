# frozen_string_literal: true
#
class IntCodeParser
  attr_reader :output
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
      opcode, modes = parse_header
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

  def parse_header
    header = ("%04d" % @data[@ip]).chars
    opcode = header[-2..-1].join.to_i
    modes = header[0..-3].reverse.map(&:to_i)

    [opcode, modes]
  end

  def get_value(modes, param_nr)
    modes[param_nr - 1] != 0 ? @data[@ip + param_nr] : @data[@data[@ip + param_nr]]
  end
end

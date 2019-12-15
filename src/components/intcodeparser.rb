# frozen_string_literal: true
#
class IntCodeParser
  attr_reader :output
  def initialize(code)
    @data = code.map.with_index {|x,i| [i,x] }.to_h
    @data.default = 0
    @ip = 0
    @finished = false
    @output = 0
    @relative_base = 0
  end

  def finished?
    @finished || @ip >= @data.size
  end

  def calculate(input = [])
    until finished?
      opcode, modes = parse_header
      case opcode
      when 99
        @finished = true
        break
      when 1
        x = get_value(modes, 1)
        y = get_value(modes, 2)

        set_value(modes, 3, x + y)
        @ip += 4
      when 2
        x = get_value(modes,1)
        y = get_value(modes,2)

        set_value(modes, 3, x * y)
        @ip += 4
      when 3
        set_value(modes, 1, input.shift)
        @ip += 2
      when 4
        @output = get_value(modes,1)
        @ip += 2
        break
      when 5
        @ip = get_value(modes,1) != 0 ? get_value(modes,2) : @ip + 3
      when 6
        @ip = get_value(modes,1) == 0 ? get_value(modes,2) : @ip + 3
      when 7
        set_value(modes, 3, get_value(modes,1) < get_value(modes,2) ? 1 : 0)
        @ip += 4
      when 8
        set_value(modes, 3, get_value(modes,1) == get_value(modes,2) ? 1 : 0)
        @ip += 4
      when 9
        @relative_base += get_value(modes, 1)
        @ip += 2
      else
        throw 'opcode fiasco'
      end
    end

    @output
  end

  private

  def parse_header
    header = ("%05d" % @data[@ip]).chars
    opcode = header[-2..-1].join.to_i
    modes = header[0..-3].reverse.map(&:to_i)

    [opcode, modes]
  end

  def get_value(modes, param_nr)
    case modes[param_nr - 1]
    when 0
      @data[@data[@ip + param_nr]]
    when 1
      @data[@ip + param_nr]
    when 2
      @data[@data[@ip + param_nr] + @relative_base]
    else
      throw 'mode fiasco'
    end
  end

  def set_value(modes, param_nr, value)
    case modes[param_nr - 1]
    when 0
      @data[@data[@ip + param_nr]] = value
    when 2
      @data[@data[@ip + param_nr] + @relative_base] = value
    else
      throw 'mode fiasco'
    end
  end
end

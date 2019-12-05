# frozen_string_literal: true
def get_value(data, modes, ip, param_nr)
  modes[param_nr - 1] != 0 ? data[ip + param_nr] : data[data[ip + param_nr]]
end

def calculate_intcode_output(input, data_orig)
  data = data_orig.clone
  ip = 0
  output = 0
  while ip < data.size
    header = ("%04d" % data[ip]).chars
    opcode = header[-2..-1].join.to_i
    modes = header[0..-3].reverse.map(&:to_i)
    case opcode
    when 99
      break
    when 1
      x = get_value(data, modes, ip, 1)
      y = get_value(data, modes, ip, 2)

      data[data[ip + 3]] = x + y
      ip += 4
    when 2
      x = get_value(data, modes, ip, 1)
      y = get_value(data, modes, ip, 2)

      data[data[ip + 3]] = x * y
      ip += 4
    when 3
      data[data[ip + 1]] = input
      ip += 2
    when 4
      output = get_value(data, modes, ip, 1)
      ip += 2
    when 5
      ip =  get_value(data, modes, ip, 1) != 0 ? get_value(data, modes, ip, 2) : ip + 3
    when 6
      ip =  get_value(data, modes, ip, 1) == 0 ? get_value(data, modes, ip, 2) : ip + 3
    when 7
      data[get_value(data, modes, ip, 3)] = get_value(data, modes, ip, 1) < get_value(data, modes, ip, 2) ? 1 : 0
      ip += 4
    when 8
      data[get_value(data, modes, ip, 3)] = get_value(data, modes, ip, 1) == get_value(data, modes, ip, 2) ? 1 : 0
      ip += 4
    else
      throw 'Fiasco'
    end
  end

  output
end
# load data
data_orig = File.read('res/day5.txt').split(',').map(&:to_i)

# part 1
p calculate_intcode_output(1, data_orig)

# part 2
p calculate_intcode_output(5, data_orig)

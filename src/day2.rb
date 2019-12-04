# frozen_string_literal: true

def calculate_intcode_output(noun, verb, data_orig)
  data = data_orig.clone
  data[1] = noun
  data[2] = verb
  data.each_slice(4) do |v|
    data[v[3]] = case v.first
                 when 99
                   break
                 when 1
                   data[v[1]] + data[v[2]]
                 when 2
                   data[v[1]] * data[v[2]]
                 else
                   throw 'Fiasco'
                 end
  end
  data.first
end

# load data
data_orig = File.read('res/day2.txt').split(',').map(&:to_i)

# part 1
p calculate_intcode_output(12, 2, data_orig)

# part 2
(0...99).each do |noun|
  (0...99).each do |verb|
    if calculate_intcode_output(noun, verb, data_orig) == 19_690_720
      p 100 * noun + verb
      break
    end
  end
end

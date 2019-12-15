require_relative 'components/intcodeparser'

input = File.read('res/day13.txt').split(',').map(&:to_i)

# part 1
blocks = 0
computer = IntCodeParser.new(input.clone)
until computer.finished?
  computer.calculate
  computer.calculate
  blocks += 1 if computer.calculate == 2
end

p blocks

# part 2
# hack the memory
input[0] = 2

score = 0
ball_pos = 0
paddle_pos = 0
joystick_pos = 0

computer = IntCodeParser.new(input.clone)
until computer.finished?
  x = computer.calculate [joystick_pos]
  y = computer.calculate [joystick_pos]
  tile_id = computer.calculate [joystick_pos]

  if x == -1 and y == 0
    score = tile_id
  elsif tile_id == 3
    paddle_pos = x
  elsif tile_id == 4
    ball_pos = x
  end

  joystick_pos = ball_pos - paddle_pos <=> 0
end

p score

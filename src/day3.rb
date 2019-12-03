def create_wire(instructions)
  wire = [[0,0]]
  instructions.each do |action|
    direction = action[0]
    value = action[1..].to_i

    x,y = wire.last

    case direction
    when 'U'
      (1..value).each {|i| wire << [x, y + i]}
    when 'D'
      (1..value).each {|i| wire << [x, y - i]}
    when 'L'
      (1..value).each {|i| wire << [x - i, y]}
    when 'R'
      (1..value).each {|i| wire << [x + i, y]}
    else
      throw 'Fiasco'
    end
  end

  wire
end

wire1, wire2 = File.readlines('res/day3.txt').map{|x| x.strip.split(',')}.map{|w| create_wire(w)}
intersections = (wire1 & wire2)[1..]

# part 1
p intersections.map{|p| p.map(&:abs).sum}.min

# part 2
p intersections.map{|i| wire1.index(i) + wire2.index(i)}.min

def count_visible_meteors(chart, base_x, base_y)
  slopes = Hash.new([])
  (-base_y...HEIGHT - base_y).each do |y|
    (-base_x...WIDTH - base_x).each do |x|
      if chart[y + base_y][x + base_x]
        slopes[Math.atan2(x, y)] += [[y + base_y,x + base_x]]
      end
    end
  end

  slopes
end

chart = File.read('res/day10.txt').lines.map{|line| line.strip.chars.map {|x| x == '#'}}
WIDTH = chart.first.size
HEIGHT = chart.size

# part 1
max_slopes = {}
(0...HEIGHT).each do |y|
  (0...WIDTH).each do |x|
    if chart[y][x]
      slopes = count_visible_meteors(chart, x, y)
      if slopes.count > max_slopes.count
        max_slopes = slopes
        #p "new max at x: #{x}, y: #{y} = #{max_slopes.count}"
      end
    end
  end
end
p max_slopes.count

# part 2
p max_slopes.to_a.sort.reverse[199]
image = File.read('res/day8.txt')
            .chars
            .map(&:to_i)

WIDTH = 25.freeze
HEIGHT = 6.freeze

# part 1
l = image.each_slice(WIDTH*HEIGHT)
         .to_a
         .min_by {|l| l.count(0)}
p l.count(1) * l.count(2)

# part 2
image.each_slice(WIDTH*HEIGHT)
     .to_a
     .transpose
     .map { |pixel| pixel.reject{|l| l == 2}
                         .first
                         .zero? ? ' ' : '*' }
     .each_slice(WIDTH) { |line| puts line.join }
# frozen_string_literal: true

lowest, highest = File.read('res/day4.txt').split('-').map(&:to_i)
part1 = (lowest...highest)
           .map(&:to_s)
           .select do |n|
              n.chars
              .each_cons(2)
              .all? { |a, b| a <= b }
           end
           .reject do |n|
              n.size == n.chars
              .chunk(&:itself)
              .map(&:first)
              .size
           end
part2 = part1.reject do |n|
              n.chars
               .chunk(&:itself)
               .select { |v| v[1].size == 2 }
               .empty?
            end

p part1.size
p part2.size

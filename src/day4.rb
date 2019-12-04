# frozen_string_literal: true

lowest, highest = File.read('res/day4.txt').split('-')
part1 = (lowest...highest)
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

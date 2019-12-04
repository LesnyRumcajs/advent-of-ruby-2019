# frozen_string_literal: true

lowest, highest = File.read('res/day4.txt').split('-').map(&:to_i)
day1 = (lowest...highest)
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
day2 = day1.reject do |n|
              n.chars
               .chunk(&:itself)
               .select { |v| v[1].size == 2 }
               .empty?
            end

p day1.size
p day2.size

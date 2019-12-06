input = File.readlines('res/day6.txt')

data = input.map { |v| v.strip.split(')')}.map { |v| {:parent => v[0], :id => v[1]}}

map = {}
data.each { |v| map[v[:id]] = v }

# part 1
traversed = []
data.each do |v|
  current = []
  loop do
    current << v[:parent]
    break unless map.has_key?(v[:parent])
    v = map[v[:parent]]
  end
  traversed << current
end

p traversed.flatten.size

# part 2
require_relative '../src/graphs/graph'
graph = UnweightedNonDirectedGraph.new
input.map { |v| v.strip.split(')')}.each { |v| graph.add_edge(v[0], v[1])}

p graph.shortest_path("YOU", "SAN").size - 3

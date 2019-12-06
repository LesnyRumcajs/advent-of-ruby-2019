class UnweightedNonDirectedGraph
  def initialize
    @graph = Hash.new {|k,v| k[v] = []}
  end

  def add_edge(source, target)
      @graph[source] << target unless @graph[source].include? target
      @graph[target] << source unless @graph[source].include? source
  end

  def shortest_path(source, target)
    edges = {}
    bfs(source, edges)
    path = []

    while target != source do
      path.unshift(target)
      target = edges[target]
    end

    path.unshift(source)
  end

  def bfs(source, edges)
    queue = [source]
    visited = [source]

    until queue.empty?
      current = queue.shift

      @graph[current].each do |node|
        next if visited.include? node
        queue << node
        visited << node
        edges[node] = current
      end
    end
  end

end

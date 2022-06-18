def add_nodes(graph, list)
  list.each do |node|
    graph.add_node(node, {})
  end
end

def add_edges(graph, list)
  list.each do |edge|
    graph.add_edge(*edge)
  end
end

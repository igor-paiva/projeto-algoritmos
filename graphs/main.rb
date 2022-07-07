require_relative 'graph'

graph_one = Graph.new(directed: false)
graph_two = Graph.new(directed: true)

File.open('../../pa/trab_grafos1/src/assets/mapData.json') do |file|
  json = JSON.parse(file.read)

  json['points_of_interest'].each do |poi|
    graph_one.add_node(poi['id'], poi['properties'])
  end

  json['roads'].each do |road|
    graph_one.add_node(road['id'], road['properties'])
  end

  json['edges'].each do |edge|
    graph_one.add_edge(*edge)
  end
end

graph_two.add_node('s', {})
graph_two.add_node(2, {})
graph_two.add_node(3, {})
graph_two.add_node(4, {})
graph_two.add_node(5, {})
graph_two.add_node(6, {})
graph_two.add_node(7, {})
graph_two.add_node('t', {})

graph_two.add_edge('s', 2, 9)
graph_two.add_edge('s', 6, 14)
graph_two.add_edge('s', 7, 15)

graph_two.add_edge(2, 3, 23)

graph_two.add_edge(3, 't', 19)
graph_two.add_edge(3, 5, 2)

graph_two.add_edge(4, 3, 6)
graph_two.add_edge(4, 't', 6)

graph_two.add_edge(5, 4, 11)
graph_two.add_edge(5, 't', 16)

graph_two.add_edge(6, 3, 18)
graph_two.add_edge(6, 5, 30)
graph_two.add_edge(6, 7, 5)

graph_two.add_edge(7, 5, 20)
graph_two.add_edge(7, 't', 44)

path = graph_two.dijkstra('s', 't')
puts path
puts

path = graph_one.dijkstra('nilfgaardian_garrison', 'mill') # r_08 # poi_27
puts path

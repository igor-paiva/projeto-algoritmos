require 'json'
require_relative 'heap'
require_relative 'tree'

class MyException < StandardError; end

class CostGraphNode
  attr_reader :id
  attr_reader :data

  def initialize(id, data)
    @id = id
    @data = data
  end
end

class CostGraph
  attr_reader :nodes
  attr_reader :directed

  def initialize(nodes: {}, directed: false)
    @time = 0
    @nodes = nodes
    @directed = directed
  end

  def length
    nodes.length
  end

  def edges
    sum_all_degrees = nodes.values.sum { |v| v[:adj_list].length }

    return sum_all_degrees / 2 unless directed

    sum_all_degrees
  end

  def print_adj_list
    nodes.each do |node, data|
      puts "#{node} => #{data[:adj_list]}"
    end
  end

  def node_exists?(id)
    nodes.has_key?(id)
  end

  def add_edge(src, dest, cost = 1)
    raise_exception("node '#{src}' does not exist") unless node_exists?(src)

    raise_exception("node '#{dest}' does not exist") unless node_exists?(dest)

    add_one_dir_edge(src, dest, cost)

    add_one_dir_edge(dest, src, cost) unless directed
  end

  def add_node(id, data)
    raise_exception('Duplicated ID') if node_exists?(id)

    node = CostGraphNode.new(id, data)

    nodes[id] = { node: node, adj_list: [] }
  end

  def dijkstra(start, dest)
    path = []
    predecessors = dijkstra_algorithm(start, dest)

    return nil unless predecessors.has_key?(dest)

    loop do
      path << dest

      break if dest == start

      dest = predecessors[dest]
    end

    path.reverse
  end

  private

  def raise_exception(msg)
    raise MyException.new(msg)
  end

  def add_one_dir_edge(src, dest, cost)
    nodes[src][:adj_list] << { to: dest, cost: cost}
  end

  def dijkstra_algorithm(start, dest)
    distances = {}
    predecessors = {}

    heap = Heap.new(type: :min)
    heap.insert(start, 0)

    while !heap.empty?
      smallest = heap.remove
      distances[smallest.id] = smallest.priority

      break if smallest.id == dest

      nodes.dig(smallest.id, :adj_list).each do |data|
        vwLength = distances[smallest.id] + data[:cost]

        if distances.has_key?(data[:to])
          raise_exception('Found better path to already-final vertex') if vwLength < distances[data[:to]]
        elsif !heap.els_hash.has_key?(data[:to])
          heap.insert(data[:to], vwLength)

          predecessors[data[:to]] = smallest.id
        elsif vwLength < heap.get_item(data[:to]).priority
          heap.change_priority(data[:to], vwLength)

          predecessors[data[:to]] = smallest.id
        end
      end
    end

    predecessors
  end
end

def main
  graph_one = CostGraph.new(directed: false)
  graph_two = CostGraph.new(directed: true)

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

  # heap = Heap.new(type: :min)

  # pos = heap.insert(1, -20)
  # puts "list[#{pos}] => #{heap.list[pos]}"

  # pos = heap.insert(2, 11)
  # puts "list[#{pos}] => #{heap.list[pos]}"

  # pos = heap.insert(3, 23)
  # puts "list[#{pos}] => #{heap.list[pos]}"

  # pos = heap.insert(4, 17)
  # puts "list[#{pos}] => #{heap.list[pos]}"

  # pos = heap.insert(5, -2)
  # puts "list[#{pos}] => #{heap.list[pos]}"

  # pos = heap.insert(6, 23)
  # puts "list[#{pos}] => #{heap.list[pos]}"

  # pos = heap.insert(7, -15)
  # puts "list[#{pos}] => #{heap.list[pos]}"

  # pos = heap.insert(8, -7)
  # puts "list[#{pos}] => #{heap.list[pos]}"

  # puts "remove #{heap.remove.id}"

  # puts heap.els_hash

  # # heap.change_priority(3, -16)
  # heap.change_priority(2, 25)

  # puts "\n\nafter change"
  # puts heap.els_hash

  # puts "remove #{heap.remove.id}"
  # puts "remove #{heap.remove.id}"
  # puts "remove #{heap.remove.id}"
  # puts "remove #{heap.remove.id}"
  # puts "remove #{heap.remove.id}"
  # puts "remove #{heap.remove.id}"

  # puts 'deve ser 2'
  # puts "remove #{heap.remove.id}"

  # puts "\n\nheap list"
  # heap.list.each_with_index do |item, idx|
  #   break if idx - 1 == heap.num

  #   puts "list[#{idx}] => #{item}"
  # end
end

main()

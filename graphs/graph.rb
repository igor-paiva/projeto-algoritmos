require 'json'
require_relative 'heap'
require_relative 'tree'

class MyException < StandardError; end

class GraphNode
  attr_reader :id
  attr_reader :data

  def initialize(id, data)
    @id = id
    @data = data
  end
end

class Graph
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

    node = GraphNode.new(id, data)

    nodes[id] = { node: node, adj_list: [] }
  end

  def reverse
    raise_exception('"reverse" only applies to directed graphs') unless directed

    reversed_nodes = reverse_graph_nodes

    Graph.new(nodes: reversed_nodes, directed: directed)
  end

  def reverse!
    raise_exception('"reverse" only applies to directed graphs') unless directed

    @nodes = reverse_graph_nodes
  end

  def strongly_connected_components
    scc_components = []

    heap = dfs_numbering(heap: true)

    reverse_graph = self.reverse

    while !heap.empty?
      item = heap.remove

      if reverse_graph.node_exists?(item.id)
        tree = reverse_graph.depth_first_search(item.id)

        tree.traverse(tree.root, "\t", -> (id)  { reverse_graph.remove_node(id) })

        scc_components << tree
      end
    end

    scc_components
  end

  def remove_node(id)
    return nil unless node_exists?(id)

    node_data = nodes.delete(id)

    nodes.each do |_, data|
      data[:adj_list].filter! { |edge| edge[:to] != id }
    end

    node_data
  end

  def strongly_connected?
    raise_exception('"strongly_connected?" only applies to directed graphs') unless directed

    node = nodes.first[0]
    visited_regular = {}
    visited_reversed = {}

    bfs_from_start(node, visited_regular)

    return false if visited_regular.length != self.length

    bfs_from_start(node, visited_reversed, reverse_graph_nodes)

    visited_regular.length == visited_reversed.length && visited_regular.length == self.length
  end

  def directed_acyclic?
    raise_exception('"directed_acyclic?" only applies to directed graphs') unless directed

    count_incoming_edges.has_value?(0)
  end

  def topological_order
    result = []
    count = count_incoming_edges

    nodes_with_no_incoming_edges = count.select { |_, value| value == 0 }.keys

    if nodes_with_no_incoming_edges.empty?
      raise_exception('The graph it is not a Directed Acyclic Graph(DAG)')
    end

    nodes.length.times do
      v = nodes_with_no_incoming_edges.first

      result << v

      nodes_with_no_incoming_edges.delete(v)

      nodes[v][:adj_list].each do |neighbor|
        count[neighbor[:to]] -= 1

        nodes_with_no_incoming_edges << neighbor[:to] if count[neighbor[:to]] == 0
      end
    end

    result
  end

  def bipartite?
    visited = {}
    colors = {}

    nodes.keys.each do |s|
      next if visited[s]

      queue = [s]

      visited[s] = true
      colors[s] = false

      while !queue.empty?
        u = queue.pop

        nodes.dig(u, :adj_list).each do |edge|
          unless visited[edge[:to]]
            visited[edge[:to]] = true
            colors[edge[:to]] = !colors[u]

            queue.push(edge[:to])
          else
            return false if colors[u] == colors[edge[:to]]
          end
        end
      end
    end

    true
  end

  def breadth_first_search(start = nil, dest = nil)
    return bfs_from_start_to_dest(start, dest) if start && dest

    return bfs_from_start(start) if start

    return bfs
  end

  def depth_first_search(start = nil, dest = nil)
    return dfs_from_start_to_dest(start, dest) if start && dest

    return dfs_visit(start) if start

    return dfs
  end

  def dfs_numbering(heap: true)
    @time = 1
    prev = {}
    post = {}

    dfs(prev, post)

    return prev, post unless heap

    heap = Heap.new(type: :max)

    post.each { |id, value| heap.insert(id, value) }

    @time = 0

    heap
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

  def count_incoming_edges
    count = Hash[nodes.keys.map { |x| [x, 0] }]

    nodes.each do |_, data|
      data[:adj_list].each do |edge|
        count[edge[:to]] += 1
      end
    end

    count
  end

  def reverse_graph_nodes
    raise_exception('Reverse only applies to directed graphs') unless directed

    new_nodes = {}

    nodes.each do |id, data|
      new_nodes[id] = { node: GraphNode.new(id, data[:node].data), adj_list: [] }
    end

    nodes.reverse_each do |node, data|
      data[:adj_list].each do |edge|
        new_nodes.dig(edge[:to], :adj_list).prepend({ to: node, cost: edge[:cost] })
      end
    end

    new_nodes
  end

  def raise_exception(msg)
    raise MyException.new(msg)
  end

  def dfs_from_start_to_dest(start, dest)
    puts 'WIP'
  end

  def dfs(prev = {}, post = {})
    trees = []
    visited = {}

    nodes.keys.each do |v|
      next if visited[v]

      trees << dfs_visit(v, visited, nil, prev, post)
    end

    trees
  end

  def dfs_visit(v, visited = {}, tree = nil, prev = {}, post = {})
    visited[v] = true
    prev[v] = @time
    @time += 1

    tree ||= Tree.new(TreeNode.new(v))

    nodes.dig(v, :adj_list).each do |edge|
      unless visited[edge[:to]]
        tree.insert(tree.root, v, TreeNode.new(edge[:to]))

        dfs_visit(edge[:to], visited, tree, prev, post)
      end
    end

    post[v] = @time
    @time += 1

    tree
  end

  def bfs
    trees = []
    visited = {}

    nodes.keys.each do |s|
      next if visited[s]

      trees << bfs_from_start(s, visited)
    end

    trees
  end

  def bfs_from_start(start, visited = {}, nodes = @nodes)
    queue = [start]

    visited[start] = true

    tree = Tree.new(TreeNode.new(start))

    while !queue.empty?
      u = queue.shift

      nodes.dig(u, :adj_list).each do |edge|
        unless visited[edge[:to]]
          visited[edge[:to]] = true

          tree.insert(tree.root, u, TreeNode.new(edge[:to]))

          queue.push(edge[:to])
        end
      end
    end

    tree
  end

  def bfs_from_start_to_dest(start, dest)
    queue = [[start]]
    visited = { start => true }

    while !queue.empty?
      path = queue.shift
      u = path.last

      return path if u == dest

      nodes.dig(u, :adj_list).each do |edge|
        unless visited[edge[:to]]
          queue.push(path + [edge[:to]])

          visited[edge[:to]] = true
        end
      end
    end

    []
  end

  def add_one_dir_edge(src, dest, cost)
    nodes[src][:adj_list] << { to: dest, cost: cost }
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
        current_distance = distances[smallest.id] + data[:cost]

        if distances.has_key?(data[:to])
          raise_exception('Found better path to already-final vertex') if current_distance < distances[data[:to]]
        elsif !heap.els_hash.has_key?(data[:to])
          heap.insert(data[:to], current_distance)

          predecessors[data[:to]] = smallest.id
        elsif current_distance < heap.get_item(data[:to]).priority
          heap.change_priority(data[:to], current_distance)

          predecessors[data[:to]] = smallest.id
        end
      end
    end

    predecessors
  end
end

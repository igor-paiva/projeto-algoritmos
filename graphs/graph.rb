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
  attr_reader :visited
  attr_reader :directed

  def initialize(directed = true)
    @visited = {}
    @nodes = {}
    @directed = directed
  end

  def length
    nodes.length
  end

  def edges
    sum_all_degrees = nodes.values.sum { |v| v[:adj_list].length }

    return sum_all_degrees / 2 if directed

    sum_all_degrees
  end

  def node_exists?(id)
    nodes.has_key?(id)
  end

  def add_edge(src, dest)
    raise_exception("node '#{src}' does not exist") unless node_exists?(src)

    raise_exception("node '#{dest}' does not exist") unless node_exists?(dest)

    add_one_dir_edge(src, dest)

    add_one_dir_edge(dest, src) if directed
  end

  def add_node(id, data)
    raise_exception('Duplicated ID') if node_exists?(id)

    node = GraphNode.new(id, data)

    nodes[id] = { node: node, adj_list: [] }
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

  def clear_visited
    @visited = {}
  end

  private

  def raise_exception(msg)
    raise MyException.new(msg)
  end

  def dfs_from_start_to_dest(start, dest)
    puts 'WIP'
  end

  def dfs
    trees = []

    nodes.keys.each do |v|
      next if visited[v]

      trees << dfs_visit(v)
    end

    trees
  end

  def dfs_visit(v, tree = nil)
    visit_node(v)

    tree ||= Tree.new(TreeNode.new(v))

    nodes.dig(v, :adj_list).each do |w|
      unless visited[w]
        # puts "#{v} - #{w}"

        tree.insert(tree.root, v, TreeNode.new(w))

        dfs_visit(w, tree)
      end
    end

    tree
  end

  def bfs_from_start_to_dest(start, dest)
    puts 'WIP'
  end

  def bfs
    trees = []

    nodes.keys.each do |s|
      next if visited[s]

      trees << bfs_from_start(s)
    end

    trees
  end

  def bfs_from_start(start)
    queue = [start]

    visit_node(start)

    tree = Tree.new(TreeNode.new(start))

    while !queue.empty?
      u = queue.pop

      nodes.dig(u, :adj_list).each do |v|
        unless visited[v]
          # puts "#{u} - #{v}"

          visit_node(v)

          tree.insert(tree.root, u, TreeNode.new(v))

          queue.push(v)
        end
      end
    end

    tree
  end

  def add_one_dir_edge(src, dest)
    nodes[src][:adj_list] << dest
  end

  def visit_node(node)
    visited[node] = true
  end
end

def main
  graph = Graph.new()

  graph.add_node(1, {})
  graph.add_node(2, {})
  graph.add_node(3, {})
  graph.add_node(4, {})
  graph.add_node(5, {})
  graph.add_node(6, {})
  graph.add_node(7, {})

  graph.add_edge(1, 4)
  graph.add_edge(1, 5)
  graph.add_edge(1, 2)
  graph.add_edge(4, 2)
  graph.add_edge(4, 5)
  graph.add_edge(2, 6)

  graph.add_edge(3, 7)

  puts "Number of nodes: #{graph.length}\n"
  puts "Number of edges: #{graph.edges}\n\n"

  puts 'DFS sem nó de início'
  Tree.traverse_trees(graph.depth_first_search())
  graph.clear_visited
  puts

  puts 'DFS com nó de início'
  tree = graph.depth_first_search(1)
  tree.traverse(tree.root, "\t")
  graph.clear_visited
  puts

  # puts 'DFS com nó de início e nó de destino'
  # graph.depth_first_search(1, 6)
  # graph.clear_visited

  puts "\n-------------------------------------------------------\n\n"

  puts 'BFS sem nó de início:'
  Tree.traverse_trees(graph.breadth_first_search())
  graph.clear_visited
  puts

  puts 'BFS com nó de início:'
  tree = graph.breadth_first_search(1)
  tree.traverse(tree.root, "\t")
  graph.clear_visited
  puts

  # puts 'BFS com nó de início e nó de destino'
  # graph.breadth_first_search(1, 6)
  # graph.clear_visited
end

main()

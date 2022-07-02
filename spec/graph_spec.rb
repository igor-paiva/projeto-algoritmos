require 'helpers'
require_relative '../graphs/graph'

RSpec.describe Graph do
  describe "#strongly_connected_components" do
    graph = Graph.new(directed: true)

    add_nodes(graph, ['s', 'v', 'w', 'q', 't', 'x', 'z', 'y', 'r', 'u'])
    add_edges(
      graph,
      [['s', 'w'], ['w', 'v'], ['v', 's'], ['s', 'q'], ['w', 'q'], ['t', 'q'], ['q', 'y'], ['y', 't'], ['x', 't'], ['z', 'x'], ['x', 'z'], ['y', 'r'], ['y', 'u'], ['u', 'r']]
    )

    it 'return the SCC components as trees' do
      sccs = graph.strongly_connected_components

      expected_sccs = [
        Tree.new(
          TreeNode.new('x', [TreeNode.new('z')]),
        ),
        Tree.new(TreeNode.new('s', [TreeNode.new('v', [TreeNode.new('w')])])),
        Tree.new(TreeNode.new('q', [TreeNode.new('t', [TreeNode.new('y')])])),
        Tree.new(TreeNode.new('u')),
        Tree.new(TreeNode.new('r')),
      ]

      expect(sccs).to match_array(expected_sccs)
    end
  end

  describe "#dfs_numbering" do
    graph = Graph.new(directed: true)

    add_nodes(graph, ('a'..'h').to_a)
    add_edges(
      graph,
      [['a', 'b'], ['c', 'b'], ['d', 'b'], ['e', 'b'], ['b', 'e'], ['d', 'c'], ['d', 'e'], ['d', 'f'], ['h', 'f'], ['f', 'h'], ['f', 'g'], ['f', 'e'], ['g', 'd']]
    )

    it 'return the prev and post with the counted time for each node' do
      prev, post = graph.dfs_numbering(heap: false)

      expect(prev).to eq({"a"=>1, "b"=>2, "e"=>3, "c"=>7, "d"=>9, "f"=>10, "h"=>11, "g"=>13})
      expect(post).to eq({"e"=>4, "b"=>5, "a"=>6, "c"=>8, "h"=>12, "g"=>14, "f"=>15, "d"=>16})
    end

    it 'return a heap with the post count info' do
      heap = graph.dfs_numbering

      mapped_list = heap.list.map { |item| [item&.id, item&.priority] }

      expect(heap.type).to eq :max
      expect(heap.num).to eq graph.length
      expect(mapped_list).to eq([[nil, nil], ['d', 16], ['f', 15], ['g', 14], ['c', 8], ['a', 6], ['b', 5], ['h', 12], ['e', 4]])
    end
  end

  describe "#topological_order" do
    it 'return the topological order as an array of IDs' do
      graph = Graph.new(directed: true)

      add_nodes(graph, Array.new(7) { |i| i + 1 })
      add_edges(
        graph,
        [[1, 4], [1, 5], [1, 7], [2, 6], [2, 5], [2, 3], [3, 5], [3, 4], [4, 5], [5, 6], [5, 7], [6, 7]]
      )

      expect(graph.directed_acyclic?).to be true
      expect(graph.topological_order).to match_array([1, 2, 3, 4, 5, 6, 7])
    end
  end

  describe "#depth_first_search" do
    graph = Graph.new()

    add_nodes(graph, Array.new(7) { |i| i + 1 })
    add_edges(
      graph,
      [[1, 4], [1, 5], [1, 2], [4, 2], [4, 5], [2, 6], [3, 7]]
    )

    it 'return the DFS tree when start and dest nodes are not provided' do
      expected_trees = [
        Tree.new(
          TreeNode.new(
            1,
            [TreeNode.new(4, [TreeNode.new(2, [TreeNode.new(6)]), TreeNode.new(5)])]
          ),
        ),
        Tree.new(TreeNode.new(3, [TreeNode.new(7)])),
      ]

      expect(graph.depth_first_search).to match_array(expected_trees)
    end

    context 'when the start node is provided' do
      it 'return the DFS tree starting in node 1' do
        expected_tree = Tree.new(
          TreeNode.new(
            1,
            [TreeNode.new(4, [TreeNode.new(2, [TreeNode.new(6)]), TreeNode.new(5)])]
          ),
        )

        expect(graph.depth_first_search(1)).to eq(expected_tree)
      end

      it 'return the DFS tree starting in node 4' do
        expected_tree = Tree.new(
          TreeNode.new(
            4,
            [TreeNode.new(1, [TreeNode.new(5), TreeNode.new(2, [TreeNode.new(6)])])]
          ),
        )

        expect(graph.depth_first_search(4)).to eq(expected_tree)
      end
    end
  end

  describe "#breadth_first_search" do
    graph = Graph.new()

    add_nodes(graph, Array.new(7) { |i| i + 1 })
    add_edges(
      graph,
      [[1, 4], [1, 5], [1, 2], [4, 2], [4, 5], [2, 6], [3, 7]]
    )

    it 'return the BFS tree when start and dest nodes are not provided' do
      expected_trees = [
        Tree.new(
          TreeNode.new(
            1,
            [TreeNode.new(4), TreeNode.new(5), TreeNode.new(2, [TreeNode.new(6)])]
          ),
        ),
        Tree.new(TreeNode.new(3, [TreeNode.new(7)])),
      ]

      expect(graph.breadth_first_search).to match_array(expected_trees)
    end

    context 'when the start node is provided' do
      it 'return the BFS tree starting in node 1' do
        expected_tree = Tree.new(
          TreeNode.new(
            1,
            [TreeNode.new(4), TreeNode.new(5), TreeNode.new(2, [TreeNode.new(6)])]
          ),
        )

        expect(graph.breadth_first_search(1)).to eq(expected_tree)
      end

      it 'return the BFS tree starting in node 4' do
        expected_tree = Tree.new(
          TreeNode.new(
            4,
            [TreeNode.new(1), TreeNode.new(2, [TreeNode.new(6)]), TreeNode.new(5)]
          ),
        )

        expect(graph.breadth_first_search(4)).to eq(expected_tree)
      end
    end
  end

  describe "#strongly_connected?" do
    [
      {
        num_nodes: 5,
        edges: [[1, 2], [2, 4], [3, 1], [4, 1], [4, 3], [4, 5], [5, 3]],
        expected: true
      },
      {
        num_nodes: 5,
        edges: [[2, 1], [2, 4], [3, 1], [4, 1], [4, 3], [4, 5], [5, 3]],
        expected: false
      },
    ].each do |params|
      it "Should return #{params[:expected]} edges with #{params[:num_nodes]} nodes and #{params[:edges]}" do
        graph = Graph.new(directed: true)

        add_nodes(graph, Array.new(params[:num_nodes]) { |i| i + 1 })
        add_edges(graph, params[:edges])

        expect(graph.strongly_connected?).to be params[:expected]
      end
    end
  end

  describe "#edges? and #length" do
    [
      {
        directed: true,
        num_nodes: 7,
        edges: [[1, 2], [1, 4], [1, 5], [1, 7], [3, 2], [3, 4], [3, 5], [3, 7], [6, 2], [6, 5], [6, 7]],
        expected_edges: 11
      },
      {
        directed: false,
        num_nodes: 7,
        edges: [[1, 4], [1, 5], [1, 2], [4, 2], [4, 5], [2, 6], [3, 7]],
        expected_edges: 7
      },
      {
        directed: true,
        num_nodes: 7,
        edges: [[1, 4], [1, 5], [1, 2], [4, 2], [4, 5], [2, 6], [3, 7]],
        expected_edges: 7
      },
      {
        directed: false,
        num_nodes: 8,
        edges: [[1, 2], [1, 3], [2, 4], [2, 5], [2, 3], [4, 5], [5, 6], [3, 5], [3, 7], [7, 8], [3, 8]],
        expected_edges: 11
      },
    ].each do |params|
      it "Should return #{params[:expected_edges]} edges with #{params[:num_nodes]} nodes and #{params[:edges]}" do
        graph = Graph.new(directed: params[:directed])

        add_nodes(graph, Array.new(params[:num_nodes]) { |i| i + 1 })
        add_edges(graph, params[:edges])

        expect(graph.edges).to eq(params[:expected_edges])
        expect(graph.length).to eq(params[:num_nodes])
      end
    end
  end

  describe "#bipartite?" do
    graph_one_edges = [[1, 2], [1, 4], [1, 5], [1, 7], [3, 2], [3, 4], [3, 5], [3, 7], [6, 2], [6, 5], [6, 7]]

    graph_two_edges = [[1, 2], [1, 3], [3, 4], [4, 5], [5, 1]]

    graph_three_edges = [[1, 2], [2, 3], [3, 4], [4, 5], [5, 1]]

    graph_four_edges = [[1, 2], [2, 3], [3, 4], [4, 5], [5, 6], [6, 1]]

    [
      { num_nodes: 7, edges: graph_one_edges,            expect: true,  },
      { num_nodes: 7, edges: [*graph_one_edges, [1, 3]], expect: false, },
      { num_nodes: 5, edges: graph_two_edges,            expect: true,  },
      { num_nodes: 5, edges: [*graph_two_edges, [2, 5]], expect: false, },
      { num_nodes: 5, edges: graph_three_edges,          expect: false, },
      { num_nodes: 6, edges: graph_four_edges,           expect: true, },
    ].each do |params|
      it "should return #{params[:expect]} with #{params[:num_nodes]} nodes and #{params[:edges]}" do
        graph = Graph.new()

        add_nodes(graph, Array.new(params[:num_nodes]) { |i| i + 1 })

        add_edges(graph, params[:edges])

        expect(graph.bipartite?).to be params[:expect]
      end
    end
  end
end

require 'helpers'
require_relative '../graphs/graph'

RSpec.describe Graph do
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
        graph = Graph.new(params[:directed])

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

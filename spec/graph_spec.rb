require 'helpers'
require_relative '../graphs/graph'

RSpec.describe Graph do
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

class TreeNode
  attr_reader :id
  attr_reader :children

  def initialize(id, children = [])
    @id = id
    @children = children
  end
end

class Tree
  attr_accessor :root

  def initialize(root = nil)
    @root = root
  end

  def self.traverse_trees(trees)
    trees.each_with_index do |tree, idx|
      puts "Tree #{idx}:"

      tree.traverse(tree.root, "\t")
    end
  end

  def traverse(root = @root, prefix = '')
    puts "#{prefix}#{root.id}"

    root.children.each do |child|
      traverse(child, "#{prefix}\t")
    end
  end

  def insert(root = @root, parent_id, node)
    # parent.children << Node.new(node_id)

    unless root
      root = node
    else
      if root.id == parent_id
        root.children << node
      else
        root.children.length.times do |i|
          if root.children[i].id == parent_id
            insert(root.children[i], parent_id, node);
          else
            insert(root.children[i], parent_id, node);
          end
        end
      end
    end
  end
end

def main
  # tree = Tree.new(TreeNode.new(1, [TreeNode.new(2, [TreeNode.new(6)])]))
  # tree.traverse

  other_tree = Tree.new(
    TreeNode.new(
      'A',
      [
        TreeNode.new(
          'B',
          [
            TreeNode.new(
              'K',
              [
                TreeNode.new('N'),
                TreeNode.new('M')
              ]
            ),
            TreeNode.new('J')
          ]
        ),
        TreeNode.new('F'),
        TreeNode.new('D', [TreeNode.new('G')]),
        TreeNode.new(
          'E',
          [
            TreeNode.new('C'),
            TreeNode.new('H'),
            TreeNode.new('I', [TreeNode.new('L')])
          ]
        )
      ]
    )
  )
  other_tree.traverse
end

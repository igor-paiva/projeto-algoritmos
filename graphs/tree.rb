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

  def self.compare_trees(root, other_root)
    return false if root.id != other_root.id

    # não sei se é legal fazer isso, é bom que não precisa fazer
    # a descida recursiva, mas se tiver muitos filhos não é algo legal
    return false if root.children.map(&:id).sort != other_root.children.map(&:id).sort

    root.children.each_with_index do |child, idx|
      cmp = compare_trees(child, other_root.children[idx])

      return false unless cmp
    end

    true
  end

  def to_s
    traverse(@root, "\t")
  end

  def ==(other_tree)
    Tree.compare_trees(self.root, other_tree.root)
  end

  def traverse(root = @root, prefix = '', callback = nil)
    if callback
      callback.call(root.id)
    else
      puts "#{prefix}#{root.id}"
    end

    root.children.each do |child|
      traverse(child, "#{prefix}\t", callback)
    end
  end

  def insert(root = @root, parent_id, node)
    unless root
      root = node
      return
    end

    if root.id == parent_id
      root.children << node
    else
      root.children.length.times do |i|
        insert(root.children[i], parent_id, node)
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

include Comparable

class Node
  attr_reader :data
  attr_accessor :left, :right

  def <=>(other)
    data <=> other.data
  end

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  attr_reader :input
  attr_accessor :root

  def initialize(input)
    @input = input.uniq.sort
    @root = build_tree(self.input)
  end

  def build_tree(arr, start = 0, fin = arr.length - 1)
    return if start > fin

    mid = (start + fin) / 2
    root = Node.new(arr[mid])

    root.left = build_tree(arr, start, mid - 1)
    root.right = build_tree(arr, mid + 1, fin)
    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

a = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
a.pretty_print

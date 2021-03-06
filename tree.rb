require_relative 'node'

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

  def insert(value, current_node = root)
    if value == current_node.data
      puts 'Value already exists.'
    elsif value < current_node.data
      if current_node.left.nil?
        current_node.left = Node.new(value)
      else
        insert(value, current_node.left)
      end
    else
      if current_node.right.nil?
        current_node.right = Node.new(value)
      else
        insert(value, current_node.right)
      end
    end
  end

  def delete(value, current_node = root)
    return nil if current_node.nil?

    if value < current_node.data
      current_node.left = delete(value, current_node.left)
    elsif value > current_node.data
      current_node.right = delete(value, current_node.right)
    else
      if current_node.left.nil?
        return current_node.right
      elsif current_node.right.nil?
        return current_node.left
      else
        current_node.data = find_next(current_node.right)
        current_node.right = delete(current_node.data, current_node.right)
      end
    end
    current_node
  end

  def find_next(current_node)
    return current_node.data if current_node.left.nil?

    find_next(current_node.left)
  end

  def find(value, current_node = root)
    return nil if current_node.nil?

    if value < current_node.data
      find(value, current_node.left)
    elsif value > current_node.data
      find(value, current_node.right)
    else
      current_node
    end
  end

  def level_order(queue = [], &proc)
    return if root.nil?

    unless block_given?
      arr = []
      proc = proc { |node| arr.push(node.data) }
    end

    queue.push(root)
    until queue.empty?
      current_node = queue.shift
      proc.call(current_node)
      queue.push(current_node.left) unless current_node.left.nil?
      queue.push(current_node.right) unless current_node.right.nil?
    end

    return arr unless block_given?
  end

  def inorder(current_node = root, &proc)
    return if current_node.nil?

    unless block_given?
      arr = []
      proc = proc { |node| arr.push(node.data) }
    end

    proc.call(current_node)
    inorder(current_node.left, &proc) unless current_node.left.nil?
    inorder(current_node.right, &proc) unless current_node.right.nil?

    return arr unless block_given?
  end

  def preorder(current_node = root, &proc)
    return if current_node.nil?

    unless block_given?
      arr = []
      proc = proc { |node| arr.push(node.data) }
    end

    preorder(current_node.left, &proc) unless current_node.left.nil?
    proc.call(current_node)
    preorder(current_node.right, &proc) unless current_node.right.nil?

    return arr unless block_given?
  end

  def postorder(current_node = root, &proc)
    return if current_node.nil?

    unless block_given?
      arr = []
      proc = proc { |node| arr.push(node.data) }
    end

    postorder(current_node.left, &proc) unless current_node.left.nil?
    postorder(current_node.right, &proc) unless current_node.right.nil?
    proc.call(current_node)

    return arr unless block_given?
  end

  def height(node)
    return 0 if node.nil?

    a = height(node.left) + 1
    b = height(node.right) + 1
    a >= b ? a : b
  end

  def depth(node, current_node = root)
    if current_node == node
      1
    elsif node < current_node
      depth(node, current_node.left) + 1
    else
      depth(node, current_node.right) + 1
    end
  end

  def balanced?(current_node = root)
    return false if (height(current_node.left) - height(current_node.right)).abs > 1

    true
  end

  def rebalance
    return if balanced?

    self.root = build_tree(preorder)
  end
end

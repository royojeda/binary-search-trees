include Comparable

class Node
  attr_reader :data

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
  def initialize(arr)
    @arr = arr
    @root = nil
  end
end

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

a = Node.new(1)
b = Node.new(2)

p a <=> b

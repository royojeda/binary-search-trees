require_relative 'node'
require_relative 'tree'

a = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
a.insert(999)
a.insert(24)
a.insert(25)
a.insert(22)
a.insert(21)
a.insert(20)
a.pretty_print
p a.balanced?
a.rebalance
a.pretty_print
p a.balanced?

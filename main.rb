require_relative 'node'
require_relative 'tree'

tree = Tree.new(Array.new(15) { rand(1..100) })
system 'clear'
tree.pretty_print

puts "\nBalanced?: #{tree.balanced?}\n\n"

puts "Level Order: #{tree.level_order}\n\n"
puts "Preorder: #{tree.preorder}\n\n"
puts "Postorder: #{tree.postorder}\n\n"
puts "Inorder: #{tree.inorder}\n\n"

5.times { tree.insert(rand(100..1000)) }
tree.pretty_print

puts "\nBalanced?: #{tree.balanced?}\n\n"

tree.rebalance
tree.pretty_print

puts "\nBalanced?: #{tree.balanced?}\n\n"

puts "Level Order: #{tree.level_order}\n\n"
puts "Preorder: #{tree.preorder}\n\n"
puts "Postorder: #{tree.postorder}\n\n"
puts "Inorder: #{tree.inorder}\n\n"

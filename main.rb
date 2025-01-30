require_relative 'lib/tree'
require_relative 'lib/node'

tree = Tree.new(Array.new(15) { rand(1..100) })

p tree.balanced?

p tree.level_order
p tree.preorder
p tree.postorder
p tree.inorder

tree.insert(101)
tree.insert(102)
tree.insert(103)

p tree.balanced?
tree.rebalance
p tree.balanced?

p tree.level_order
p tree.preorder
p tree.postorder
p tree.inorder

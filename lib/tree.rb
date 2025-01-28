require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    return nil if array.empty?
    array = array.uniq.sort
    middle = array.size / 2
    root_node = Node.new(array[middle])
    root_node.left = build_tree(array[0...middle])
    root_node.right = build_tree(array[middle + 1..-1])
    root_node
  end

  # From The Odin Project
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value, node = @root)
    return Node.new(value) if node.nil?
    if value < node.data
      node.left = insert(value, node.left)
    else
      node.right = insert(value, node.right)
    end
    node
  end

  def delete(value, node = @root)
    return node if node.nil?
    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      return node.right if node.left.nil?
      return node.left if node.right.nil?
      minimum_node = find_minimum(node.right)
      node.data = minimum_node.data
      node.right = delete(minimum_node.data, node.right)
    end
    node
  end

  def find_minimum(node)
    node = node.left until node.left.nil?
    node
  end

  def find(value, node = @root)
    return nil if node.nil?
    return node if value == node.data
    value < node.data ? find(value, node.left) : find(value, node.right)
  end

  def level_order(node = @root, values = [], &block)
    return if node.nil?
    queue = [node]
    until queue.empty?
      current = queue.shift
      block_given? ? yield(current) : values << current.data
      queue << current.left unless current.left.nil?
      queue << current.right unless current.right.nil?
    end
    values unless block_given?
  end

  def inorder(node = @root, values = [], &block)
    return if node.nil?
    inorder(node.left, values, &block)
    block_given? ? yield(node) : values << node.data
    inorder(node.right, values, &block)
    values unless block_given?
  end
end
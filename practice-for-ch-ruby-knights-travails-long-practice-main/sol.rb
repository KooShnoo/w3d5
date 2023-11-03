require 'pry'
require_relative '../practice-for-ch-ruby-poly-tree-node-long-practice-main/lib/tree_node'

class KnightPathFinder
  def self.valid_pos?(pos)
    pos.all? { |coordinate| coordinate.is_a?(Integer) && coordinate.between?(0, 7) }
  end

  def self.valid_moves(pos)
    offsets = [1, 2, -1, -2].permutation(2).to_a.reject { |i, j| i.abs == j.abs }
    # offsets = [[1, 2], [1, -2], [2, 1], [2, -1], [-1, 2], [-1, -2], [-2, 1], [-2, -1]]

    offsets.map { |ofs| pos.zip(ofs).map(&:sum) }.filter { |move| valid_pos?(move) }
  end

  def initialize(start_pos)
    @positions = [start_pos]
    @considered_positions = Set[]
    @move_tree_root = PolyTreeNode.new(start_pos)
    build_move_tree
  end

  def new_move_positions(pos)
    new_move_positions = KnightPathFinder.valid_moves(pos).reject { |move| considered_positions.include?(move) }
    self.considered_positions += new_move_positions
    new_move_positions
  end

  def build_move_tree
    node_q = [move_tree_root]
    until node_q.empty?
      searching = node_q.shift
      new_move_nodes = new_move_positions(searching.value).map { |move| PolyTreeNode.new(move) }
      searching.children = new_move_nodes
      node_q += new_move_nodes
    end
  end

  def find_path(end_pos)
    @move_tree_root.dfs(end_pos)
  end

  def trace_back_path(node)
    path = []
    until node.parent.nil?

    end
  end

  private

  attr_accessor :positions, :considered_positions, :move_tree_root
end

# nodes = ('a'..'g').map { |value| PolyTreeNode.new(value) }

# parent_index = 0
# nodes.each_with_index do |child, index|
#   next if index.zero?

#   child.parent = nodes[parent_index]
#   parent_index += 1 if index.even?
# end

binding.pry

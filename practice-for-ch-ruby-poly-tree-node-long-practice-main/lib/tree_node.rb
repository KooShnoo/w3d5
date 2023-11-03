class PolyTreeNode
  attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    parent&.children&.delete(self)
    @parent = new_parent
    new_parent&.children&.push(self)
  end

  def add_child(child)
    child.parent = self
    children.push(child) unless children.include?(child)
  end

  def remove_child(child)
    raise ArgumentError, "child not found. #{child}, please call your mom" unless children.include?(child)

    child.parent = nil
    children.delete(child)
  end

  def dfs(target)
    return self if @value == target
    return nil if children.empty?

    r1 = children[0].dfs(target)
    return r1 unless r1.nil?

    r2 = children[-1].dfs(target)
    return r2 unless r2.nil?

    nil
  end

  def bfs(target)
    node_q = [self]
    until node_q.empty?
      searching = node_q.shift
      return searching if searching.value == target

      node_q += searching.children
    end
    nil
  end

  # private

  # attr_writer :value, :children
end

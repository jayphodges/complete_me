# /lib/node.rb
class Node
  attr_accessor :complete, :children, :key

  def initialize
    @complete = false
    @children = {}
    @parent = nil
    # @priority = nil
    @key = nil
  end
end

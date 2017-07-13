# /lib/node.rb
class Node
  attr_accessor :complete,
  :children,
  :key,
  :priority

  def initialize
    @complete = false
    @children = {}
    @priority = Hash.new(0)
    @key = nil
  end
end

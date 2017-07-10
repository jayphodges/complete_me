# /lib/node.rb
class Node
  attr_accessor :complete, :children

  def initialize
    @complete = false
    @children = {}

  end
end

# /lib/node.rb
class Node
  attr_accessor :complete, :child

  def initialize
    @complete = nil
    @child = {}

  end
end

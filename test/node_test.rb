require './lib/node'
require './lib/complete_me'
# require './lib/complete_me'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'

class NodeTest < Minitest::Test
  def test_node_new_node_has_child
    node = Node.new
    expected = {}
    actual = node.child
    assert_equal expected, actual
  end
  def test_node_new_node_has_complete_attribute
    node = Node.new
    assert_nil node.complete
  end


  def test_node_complete_flag
    node = Node.new
    assert complete
  end


  def test_nodes_are_added_with_letter_key
    cm.insert("bar", current)
    assert_equal "r", current.children.children.key
  end
  # def test_node_new_node_has_left_starts_as_nil
  #   node = Node.new(50, "Movie Test")
  #   assert_equal nil, node.left
  # end
  # def test_node_new_node_has_right_starts_as_nil
  #   node = Node.new(50, "Movie Test")
  #   assert_equal nil, node.right
  # end
end
# binding.pry

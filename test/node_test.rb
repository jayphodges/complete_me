require './lib/node'
require './lib/complete_me'
# require './lib/complete_me'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'

class NodeTest < Minitest::Test
  def test_node_new_node_has_child
    cm = Node.new
    assert_equal ({}), cm.children
  end

  def test_node_new_node_has_complete_attribute
    cm = Node.new
    assert_equal false, cm.complete
  end

  def test_priority_hash
    cm = Node.new
    assert_equal ({}), cm.children
  end

  def test_node_complete_flag
    cm = Node.new
    assert_equal false, cm.complete
  end

  def test_node_complete_flag
    cm = Node.new
    assert_nil cm.key
  end
end

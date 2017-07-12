require 'simplecov'
SimpleCov.start
require './lib/node'
require './lib/complete_me'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'




class TreeTest < Minitest::Test
  attr_reader :cm
  def setup
    @cm = CompleteMe.new
  end

  def test_that_root_node_exists
    assert_instance_of CompleteMe, cm
  end

  # def insert_a_node
  #   cm = CompleteMe.new
  #   insert(x)
  #   expected = {:x}
  #   actual = cm.child[x]
  #   assert_equal expected, actual
  # end

  def test_inserts_single_word
    cm.insert("pizza")
    assert_equal 1, cm.count
  end

  def test_counts_inserted_word
    cm.insert("pizza")
    cm.insert("pie")
    cm.insert("pride")
    cm.insert("cat")
    cm.insert("burger")
    assert_equal 5, cm.count
  end

  def test_coun
    cm.insert_words(["pizza", "aardvark", "zombies", "a", "xylophones"])
    assert_equal 5, cm.count
  end

  def test_works_with_large_dataset
    cm.populate("/usr/share/dict/words")
    assert_equal 1, cm.count
  end


end

if ENV['RAILS_ENV'] == 'test'
  require 'simplecov'
  SimpleCov.start 'rails'
  puts "required simplecov"
end

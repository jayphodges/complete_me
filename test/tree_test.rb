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


  def test_input_to_array
    cm.word_to_array("bat")
    expected = ["b", "a", "t"]
    actual = cm.word_to_array("bat")
    assert_equal expected, actual
  end

  def test_array_integration
    cm.insert("bar")
    assert ["b", "a", "r"]
  end

  def test_inserts_single_word
    cm.insert("pizza")
    assert_equal 1, cm.count
  end


  def test_nodes_are_added_with_letter_key
    cm.insert("bar")
    expected = "a" #not sure how to test for just the kep?
    binding.pry
    actual = cm.root.children.keys

    assert_equal expected, actual
  end


def test_traversal_method

  cm.insert("bar")
  cm.insert("bat")
  cm.insert("barn")
  assert_equal "a", @root.children.key

end


  def test_counts_inserted_word

    cm.insert("pizza")
    cm.insert("pie")
    cm.insert("pride")
    cm.insert("cat")
    cm.insert("burger")
    assert_equal 5, cm.count
  end

  def test_count
    skip
    cm.insert_words(["pizza", "aardvark", "zombies", "a", "xylophones"])
    assert_equal 5, cm.count
  end

  def test_works_with_large_dataset
    skip
    cm.populate("/usr/share/dict/words")
    assert_equal 1, cm.count
  end

def test_suggest_method
  cm.insert('barn')
  cm.insert('bat')
  cm.insert('bar')
  cm.insert('barn')
  cm.insert('batz')
  cm.suggest("ba")

  expected =
  actual =

  assert_equal expected, actual
end

def test_collect_method
  #not sure how to test this since the input is a node; I think we want to check "collect results" against some array, but I'm not sure how to get collect results as an out put of just this method.
end

def test_return_results_method
end

def test_collect_and_return_integration
end


def test_select_method
skip
  cm.select("ba", "bar")
  # expected - we expect the "a" hash's priority hash to increase the value associated with the "bar" key  by one
end

def test_integration_of_select_and_suggest
  #expect a suggestion reults array that returns our selection at the beginning.
end

end

if ENV['RAILS_ENV'] == 'test'
  require 'simplecov'
  SimpleCov.start 'rails'
  puts "required simplecov"
end

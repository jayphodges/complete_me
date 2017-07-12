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

  def test_inserting_duplicate_words
    cm.insert("bar")
    cm.insert("bat")
    assert_equal 2, cm.count
    cm.insert("bar")
    cm.insert("bat")
    assert_equal 2, cm.count
  end

  def test_inserting_multiple_words
    cm.insert_words(["bar","bat","barn"])
    assert_equal 3, cm.count
  end

  def test_populate
    dictionary = File.read('/usr/share/dict/words')
    cm.populate(dictionary)
    assert_equal 235886, cm.count
    cm.insert("notactuallyaword")
    assert_equal 235887, cm.count
  end

  def test_priority
    cm.insert("bat")
    cm.select("ba", "bat")
    assert_equal ({"bat"=>1}), cm.root.children["b"].children["a"].priority
  end

  def test_priority_incrementing
    cm.insert("bat")
    cm.select("ba", "bat")
    assert_equal 1, cm.root.children["b"].children["a"].priority["bat"]
    cm.select("ba", "bat")
    assert_equal 2, cm.root.children["b"].children["a"].priority["bat"]
    cm.select("ba", "bat")
    assert_equal 3, cm.root.children["b"].children["a"].priority["bat"]
  end

  def test_select_return
    cm.insert("bar")
    cm.insert("bat")
    cm.insert("barn")
    cm.insert("battery")
    assert_equal ["bar", "barn", "bat", "battery"], cm.suggest("ba")
    cm.select("ba", "bat")
    assert_equal ["bat", "bar", "barn", "battery"], cm.suggest("ba")
  end

  def test_select_false_return
    cm.insert("bar")
    cm.insert("bat")
    cm.insert("barn")
    cm.insert("battery")
    assert_equal ["not"], cm.select("be", "betternotwork")
  end

  def test_nodes_are_added_with_letter_key
    cm.insert("bar")
    assert_equal "b", cm.root.children["b"].key
    assert_equal "a", cm.root.children["b"].children["a"].key
    assert_equal "r", cm.root.children["b"].children["a"].children["r"].key
  end

  def test_node_complete_flag
    cm.insert("bar")
    refute cm.root.children["b"].complete
    refute cm.root.children["b"].children["a"].complete
    assert cm.root.children["b"].children["a"].children["r"].complete
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

  def test_false_return_for_words_not_in_dictionary
    dictionary = File.read('/usr/share/dict/words')
    cm.populate(dictionary)
    assert_equal false, cm.suggest("notactuallyaword")
  end

  def test_suggest_method
    cm.insert('barn')
    cm.insert('bat')
    cm.insert('bar')
    cm.insert('battery')
    assert_equal ["bar", "barn", "bat", "battery"], cm.suggest("ba")
  end

def test_collect_method
  #not sure how to test this since the input is a node; I think we want to check "collect results" against some array, but I'm not sure how to get collect results as an out put of just this method.
end

def test_return_results_method
end

def test_collect_and_return_integration
end

  # expected - we expect the "a" hash's priority hash to increase the value associated with the "bar" key  by one
end

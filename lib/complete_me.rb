# /lib/complete_me.rb
require './lib/node'
require 'pry'

class CompleteMe
  attr_accessor :root,
                :count,
                :results,
                :traverse_results,
                :collect_results

  def initialize
    @root = Node.new
    @count = 0
    @traverse_results = []
    @collect_results = []
    @word = nil
  end

  def insert(input, current = @root)
    array = word_to_array(input)
    if !array.empty?
      first = array.shift
      if current.children.key?(first)
        insert(array, current.children[first])
      else
        current.children[first] = Node.new
        current.children[first].key = first
        insert(array, current.children[first])
      end
    else
      @count += 1 if current.complete == false
      current.complete = true
    end
  end

  def word_to_array(input)
    if input.class == Array
      input
    else
      array = input.chars
      array
    end
  end

  def insert_words(words)
    words.each { |word| insert(word) }
  end

  def populate(file)
    file.split.each do |word|
      insert(word.chomp)
    end
  end

  def suggest(input, current = @root)
    results = []
    array = word_to_array(input)
    if array.empty? == false # There are still letters in the array
      traverse_results.push(array[0])
      first = array.shift
      if current.children.key?(first) # does child have key
        suggest(array, current.children[first])
      else
        return false
      end
    else
      priority_results = current.priority
      results = collect(current)
      traverse_results.delete_at(-1)
      return_results(traverse_results, results, priority_results)
    end
  end

  def collect(current, word = '', collect_results = [])
    if current.complete && current.children.empty? != true
      word += current.key
      collect_results << word
      current.children.each_value { |node| collect(node, word, collect_results) }
    elsif current.complete && current.children.empty?
      word += current.key
      collect_results << word
    else
      word += current.key
      current.children.each_value { |node| collect(node, word, collect_results) }
    end
    collect_results
  end

  def return_results(traverse_results, collect_results, priority_results)
    prefix = traverse_results.join('')
    suggest_results = []
    priority = []
    collect_results.each do |suffix|
      suggest_results << (prefix + suffix.to_s)
    end
    traverse_results.clear
    priority_results.each_pair do |key, value|
      suggest_results.delete(key)
      priority << [key, value]
    end
    priority = priority.sort_by! do |index|
      index[1]
    end.reverse
    priority = priority.map!(&:shift)
    priority + suggest_results
  end

  def select(input, selection, current = @root)
    array = word_to_array(input)
    until array.empty?
      first = array.shift
      if current.children.key?(first) # does child have key
        select(array, selection, current.children[first])
      else
        return 'Word not in dictionary'
      end
    end
    current.priority[selection] += 1
    nil
  end
end

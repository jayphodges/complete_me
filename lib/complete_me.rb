# /lib/complete_me.rb
require './lib/node'
require 'pry'

class CompleteMe
  attr_accessor :root,
                :count,
                :results,
                :traverse_results,
                :collect_results,
                :word

  def initialize
    @root = Node.new
    @count = 0
    @traverse_results = []
    @collect_results = []
    @word = nil
  end

  def insert(input, current = @root)
    array = word_to_array(input)
    if array.empty? == false # There are still letters in the array
      first = array.shift
      if current.children.key?(first) # does child have key
        insert(array, current.children[first])
      else
        current.children[first] = Node.new
        current.children[first].key = first
        insert(array, current.children[first])
      end
    else
      @count += 1 # temporary working fix, move count to selective
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
    file.split.each do |word| # splits input according to newline value
      insert(word)
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
      results = collect(current)
      done = true
      if done
        traverse_results.delete_at(-1)
        return_results(traverse_results, results)
      end
    end
  end

  def collect(current, word = '', collect_results = [])
    if current.complete && current.children.empty? != true
      word += current.key # if current.key != nil
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

  def return_results(traverse_results, collect_results)
    prefix = traverse_results.join('')
    suggest_results = []
    collect_results.each do |suffix|
      suggest_results << (prefix + suffix.to_s)
    end
    traverse_results.clear
    return suggest_results
  end

  def select(node, word); end
end

cm = CompleteMe.new
cm.insert('barn')
cm.insert('bat')
cm.insert('bar')
cm.insert('barn')
cm.insert('batz')
cm.insert('barn')
cm.insert('com')
cm.insert('combat')
cm.insert('combative')
cm.insert('compare')
# cm.insert('pizza')
# cm.insert('pizzaria')

# cm.populate('/usr/share/dict/words')
# puts cm.count
cm.suggest('ba')
puts
cm.suggest('com')
puts
# cm.suggest('art')
# binding.pry

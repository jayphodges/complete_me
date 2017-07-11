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
      # binding.pry
      if current.children.key?(first) # does child have key
        insert(array, current.children[first])
      else
        current.children[first] = Node.new
        # current.children[first] = current # parent functionality to traverse upwards
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
    File.open(file).readlines.each do |word| # splits input according to newline value
      insert(word)
    end
  end

  # def traverse_nodes(input, current = @root)
  #   unless input == [] # .empty?
  #     if current.children.key?(input.first.to_s) # node does have children
  #       current = current.children[input.first.to_s]
  #       input.shift
  #       insert(input, current)
  #     else # node does not have children we want
  #       current.children[input.first] = Node.new
  #       current = current.children[input.first]
  #       input.shift
  #       insert(input, current)
  #     end
  #   end
  # end

  # def search(current, _results = []) # eventually the functionality of moving through the tree needs to be its own method
  #   until current.children == {} # Keep going until there are no childrenren
  #     current.children.each_value do |child_node| # each value in the array is an instance/object ID
  #       @results << current.complete
  #       current = child_node
  #       search(current, @results)
  #     end
  #   end
  # end
  # traverse = unless hash empty, each value do -> current_node = value

  def suggest(input, current = @root)
    results = []
    array = word_to_array(input)
    if array.empty? == false # There are still letters in the array
      traverse_results.push(array[0])
      first = array.shift
      # traverse_results.push(first)
      if current.children.key?(first) # does child have key
        suggest(array, current.children[first])
      else
        return false
      end
    else
      results = collect(current)
      # binding.pry
      done = true
    if done
      traverse_results.delete_at(-1)
      return_results(traverse_results, results)
    end
    end
  end

  def collect(current, word = '', collect_results = [])
    # binding.pry
    if current.complete && current.children.empty? != true
      # binding.pry
      word += current.key# if current.key != nil
      # binding.pry
      collect_results << word
      current.children.each_value {|node| collect(node, word, collect_results)}
    elsif current.complete && current.children.empty?
      # binding.pry
      word += current.key
      collect_results << word
            # binding.pry
    else
      # binding.pry
      word += current.key
            # binding.pry
      current.children.each_value {|node| collect(node, word, collect_results)}
    end
    return collect_results
    # binding.pry
  end
#------------------------------
  #   unless current.children.empty?
  #     current.children.each_pair do |letter, node|
  #       word += letter
  #       collect_results << word if node.complete
  #       # binding.pry
  #       collect(node, word)
  #     end
  #   end
  # end
#------------------------------
  #   collect_results << word if current.complete
  #   # word = nil if current.children.empty? && current.complete
  #   if !current.children.empty?
  #     binding.pry
  #     current.children.each_pair do |letter, child_node|
  #       word += letter
  #       binding.pry
  #       collect(child_node, word)
  #     end
  #   end
  #   # binding.pry
  # end
#-------------------------------
  #   collect_letters(current).each do |letter|
  #     words << letter.val if current.children != nil
  #     all_words << words if current.complete == true
  #   end
  #   return 0 if all_words.first == ''
  #   all_words
  # end
  #
  # def collect_letters(current)
  #   if current.children == []
  #     @word << current.key
  #   else
  #     current.children.each_pair do |key, node|
  #       @word << current.key
  #       collect_letters(node)
  #     end
  #   end
  #   @word
  # end
#------------------------------------
      # current.children.each_pair do |letter, node|
      #   # binding.pry
      #   # return if node.children.empty?
      #   # collect_results << letter.to_s
      #   word << letter.to_s
      #   puts word
      #   binding.pry
      #   if node.complete == true && node.children.empty?
      #     collect_results << word
      #     raise StopIteration
      #   elsif node.complete == true
      #     collect_results << word
      #     collect(node, collect_results, word)
      #   else
      #     collect(node, collect_results, word)
      #   end
      #   binding.pry
      # end
#-------------------------------------
    # until current.children.empty?
    # until current.children.empty? && done
    #   current.children.each_pair do |letter, node|
    #     word << letter
    #     binding.pry
    #     if node.complete && current.children.empty?
    #       collect_results << word
    #       done = true
    #               binding.pry
    #       collect(node, collect_results, word, done)
    #     elsif node.complete
    #       collect_results << word
    #               binding.pry
    #       collect(node, collect_results, word, done)
    #     else
    #               binding.pry
    #       collect(node, collect_results, word, done)
    #     end
    #     end
    # end

    # else
    #   collect_results << current.key.to_s.strip
    # end




def return_results(traverse_results, collect_results)
  # binding.pry
  prefix = traverse_results.join("")
  results
  collect_results.each do |suffix|
    puts prefix + suffix.to_s
    # binding.pry
  end
end

  #   elsif input.empty? == false
  #     traverse_nodes(input, current)
  #   else
  #     search(current, results)
  #   end
  #   #      binding.pry
  # end

  def select(node, word)

  end
  def prune_tree
    # Locate trees with no children
    if current.children.children.empty? && current.complete.empty?

      # until current.child == {} # Keep going until there are no children
      #   current.child.each_value do |child_node| # each value in the array is an instance/object ID
      #       @results << current.complete
      #       current = child_node
      #       dig(current, @results)
      #     end
      # end
    end
  end
end

cm = CompleteMe.new
# cm.insert('barn')
# cm.insert('bat')
# cm.insert('bar')
# cm.insert('barn')
# cm.insert('batz')
# cm.insert('barn')
# cm.insert('com')
# cm.insert('combat')
# cm.insert('combative')
# cm.insert('compare')
# cm.insert('pizza')
# cm.insert('pizzaria')




cm.populate('/usr/share/dict/words')
# puts cm.count
cm.suggest("piz")
# cm.suggest('art')
# binding.pry

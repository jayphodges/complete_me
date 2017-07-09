# /lib/complete_me.rb
require './lib/node'
require 'pry'

class CompleteMe

  attr_accessor :root

  def initialize
    @root = Node.new
    @count = 0

  def insert(input, current = @root)
    if input.class != Array
      word = input.chars # letters
      # first = word.first
    else
      traversal(input, current)
#       unless word == [] # .empty?
# #        current_letter = word.shift allows for some simplification
#         if current.child.has_key?("#{word.first}") # node does have child
#           current = current.child["#{word.first}"]
#           word.shift
#           insert(word, current)
#         else # node does not have child we want
#           current.child["#{word.first}"] = Node.new
#           current = current.child["#{word.first}"]
#           word.shift
#           insert(word, current)
#         end
#       end
#     end
    end
    current.complete = input
    @count += 1
  end


  def insert_words(words)
    words.each {|word| insert(word)}
  end

  def populate(file)
    File.open(file).readlines.each do |word| # splits input according to newline value
      insert(word)
    end
  end
      #     if include?(data[0].to_i) == true
      #       puts "#{data[1]} already exists at position #{data[0]}"
      #     else
      #       insert(data[0].to_i, data[1])
      #     end
      #   end
      # end

  def traversal(word, current = @root)
    unless word == [] # .empty?
    #        current_letter = word.shift allows for some simplification
      if current.child.has_key?("#{word.first}") # node does have child
        current = current.child["#{word.first}"]
        word.shift
        insert(word, current)
      else # node does not have child we want
        current.child["#{word.first}"] = Node.new
        current = current.child["#{word.first}"]
        word.shift
        insert(word, current)
      end
    end
  end


  def traverse(current, words = []) # eventually the functionality of moving through the tree needs to be its own method
    until current.child == {} # Keep going until there are no children
      current.child.each_value do |something| #each value in the array is an instance/object ID
      if current.complete != nil
        words << current.complete
        current = something
      end
      end
    end
  end
# traverse = unless hash empty, each value do -> current_node = value

  def suggest(input, current = @root, words = [])
    if input.class != Array # break the suggestion into an array of letters
      input = input.chars    #
      suggest(input)
    else
      until input == []
        traversal(input)
      end
      traverse(current)
    end
    puts words
  end
      # until current.child == {} # Keep going until there are no children
      #   current.child.each_value do |something| #each value in the array is an instance/object ID
      #   if current.complete != nil
      #     words << current.complete
      #     current = something
      #   end
      # end
      # end
    # traverse and look for current.complete != nil, then shovel into array

  def count
    @count
  end

  end
end

cm = CompleteMe.new
cm.insert("key")
cm.populate("/usr/share/dict/words")
puts cm.count
cm.suggest("art")

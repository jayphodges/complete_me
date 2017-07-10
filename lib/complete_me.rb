# /lib/complete_me.rb
require './lib/node'
require 'pry'

class CompleteMe
  attr_accessor :root,
                :count,
                :results

  def initialize
    @root = Node.new
    @count = 0
    @results = []
  end

    def insert(input, current = @root)
      word = input
      array = word_to_array(input)
      # if input.class != Array
      #   input = input.chars # letters
      #   insert(input)
      # else
      if array.empty? == false # There are still letters in the array
        if current.child.key(array.first) # does child have key
          current = current.child[array.first]
          array.delete_at(0)
          insert(array, current)
        else
          current.child[array.first] = Node.new
          current = current.child[array.first]
          array.delete_at(0)
          insert(array, current)
        end
      else
        @count += 1
        current.complete = word
      end
    end




















    #   until input.empty? # verify that array isn't empty
    #     # current_letter = input.shift        # current_letter = word.shift allows for some simplification
    #     if current.child.key?(input.first) # node does have child
    #       current = current.child[input.first]
    #       input.delete_at(0)
    #       insert(input, current)
    #     else # else we cannot locate the node, make new
    #       current.child[input.first] = Node.new
    #       current = current.child[input.first]
    #       # binding.pry
    #       input.delete_at(0)
    #       insert(input, current)
    #     end
    #     # current.complete = word
    #     # @count += 1
    #   end
    #     current.complete = word
    #     @count += 1
    # end
    #   # current.complete = word
    #   # @count += 1
    # end
  def word_to_array(input)
    if input.class == Array
      return input
    else
      array = input.chars
      return array
    end
  end

    # def break_word(input)
    #   if input.class != Array
    #     input = input.chars
    #     return input
    #     # insert(input)
    #   else
    #     return input
    #     # insert(input)
    #   end
    # end

    def insert_words(words)
      words.each { |word| insert(word) }
    end

    def populate(file)
      File.open(file).readlines.each do |word| # splits input according to newline value
        insert(word)
      end
    end

    def traverse_nodes(input, current = @root)
      unless input == [] # .empty?
        #        current_letter = word.shift allows for some simplification
        if current.child.key?(input.first.to_s) # node does have child
          current = current.child[input.first.to_s]
          input.shift
          insert(input, current)
        else # node does not have child we want
          current.child[input.first.to_s] = Node.new
          current = current.child[input.first.to_s]
          input.shift
          insert(input, current)
        end
      end
    end

    def search(current, results = []) # eventually the functionality of moving through the tree needs to be its own method
      until current.child == {} # Keep going until there are no children
        current.child.each_value do |child_node| # each value in the array is an instance/object ID
            @results << current.complete
            current = child_node
            search(current, @results)
          end
      end
    end
    # traverse = unless hash empty, each value do -> current_node = value

    def suggest(input, current = @root)
      if input.class != Array # break the suggestion into an array of letters
        input = input.chars #
        suggest(input)
      elsif input.empty? == false
        traverse_nodes(input, current)
      else
        search(current, results)
      end
#      binding.pry
    end

    def select(node, word)

    end

    def prune_tree
      # Locate trees with no children
      if current.child.child.empty? && current.complete.empty?

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
cm.insert('bar')
cm.insert('bat')
cm.insert('bed')
cm.insert('barn')

# cm.populate('/usr/share/dict/words')
puts cm.count

#cm.suggest('art')


# binding.pry

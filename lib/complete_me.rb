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
      # @word ||= input
      array = word_to_array(input)
      # first = array.shift
      if array.empty? == false # There are still letters in the array
        first = array.shift
        if current.children.key?(first) # does child have key
          insert(array, current.children[first])
        else
          current.children[first] = Node.new
          # current = current.children[first]
          # current.children.merge!({[first.to_s] => Node.new})
          # current.children = current.children.merge(first => Node.new)
          # current = current.children[first]
          # array.delete_at(0)
          insert(array, current.children[first])
        end
      else
        @count += 1  # temporary working fix, move count to selective
        current.complete = true
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
        if current.children.key?(input.first.to_s) # node does have children
          current = current.children[input.first.to_s]
          input.shift
          insert(input, current)
        else # node does not have children we want
          current.children[input.first] = Node.new
          current = current.children[input.first]
          input.shift
          insert(input, current)
        end
      end
    end

    def search(current, results = []) # eventually the functionality of moving through the tree needs to be its own method
      until current.children == {} # Keep going until there are no childrenren
        current.children.each_value do |child_node| # each value in the array is an instance/object ID
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
cm.insert('bat')
puts @word
# cm.insert('bat')
cm.insert('bed')
puts @word
# cm.insert('barn')

cm.populate('/usr/share/dict/words')
puts cm.count

#cm.suggest('art')



# binding.pry

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
      word = input.chars
      first = word.first
    else
      unless word == []
        if current.child.has_key?("#{first}")
          current = current.child["#{first}"]
          word.shift
          insert(word, current)
        else # node does not have child we want
          current.child["#{first}"] = Node.new
          current = current.child["#{first}"]
          word.shift
          insert(word, current)
        end
      end
    end
    current.complete = input
    @count += 1
  end

  def insert_words(words)
    words.each {|word| insert(word)}
  end

  def populate(several_arguements)
# file load functionality goes here
  end



  def suggest(string)

  end

  def count
    @count
  end

  end
end

cm = CompleteMe.new
cm.insert("key")

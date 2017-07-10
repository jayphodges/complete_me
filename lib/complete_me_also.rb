def insert(input, current = @root)
  word = input
  if input.class =! Array
    input = input.chars
    insert(input)
  elsif input == []
    count += 1
    current.complete = word
  else



def word_to_array(input)
  if input.class == Array
    return input
  else
    array = input.chars
    return array
  end

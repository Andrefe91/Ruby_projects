# Caesar Cipher implementation in Ruby for The Odin Project

def transform_upcase (character)

  character = normalize(character)

  #First, we define the configuration array for the replacements
  replacement_array_upcase = ('A'..'Z').zip(1..26).to_h

  #And now check for the replacement
  return replacement_array_upcase[character] if character.is_a? String
  return replacement_array_upcase.key(character) if character.is_a? Integer

end

def transform_downcase (character)

  character = normalize(character)

  #First, we define the configuration array for the replacements
  replacement_array_downcase = ('a'..'z').zip(1..26).to_h

  #And now check for the replacement
  return replacement_array_downcase[character] if character.is_a? String
  return replacement_array_downcase.key(character) if character.is_a? Integer

end

def normalize (character)

  if character.is_a? String
    return character
  else
    return character - 26 if character > 26
    return character if character < 26
  end
end

def caesar_transformation (phrase, shift_factor = 0)

  replaced_phrase = []

  #To operate on array, we change the phrase
  phrase_array = phrase.split('')

  phrase_array.map do |letter|
    if letter == ' '
      replaced_phrase.push(' ')

    elsif (letter =~ /[a-zA-Z]/) == nil
      replaced_phrase.push(letter)

    elsif letter == letter.upcase
      replaced_phrase.push(
        transform_upcase(transform_upcase(letter)+shift_factor)
      )

    else
      replaced_phrase.push(
        transform_downcase(transform_downcase(letter)+shift_factor)
      )
    end
  end

  replaced_phrase.join
end

puts "Please enter the phrase: "
string = gets.chomp

puts "And know the offset number: "
offset = gets.chomp.to_i


transformed_phrase = caesar_transformation(string,offset)

puts "Your transformed phrase is: \n #{transformed_phrase}"

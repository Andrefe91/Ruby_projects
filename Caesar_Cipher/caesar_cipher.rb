# Caesar Cipher implementation in Ruby for The Odin Project

def caesar_transformation (phrase, shift_factor = 0)

  transformed_phrase = ''

  phrase.each_char do |char|

    if (char.ord.between?(65,90)) || (char.ord.between?(97,122))
      
      base = char.ord.between?(65,90) ? 65 : 97

      new_char = base + (((char.ord + shift_factor)-base) % 26)

      transformed_phrase += new_char.chr
    elsif
      # Ignore the non alphabetic characters
      transformed_phrase += char
    end
  end

  transformed_phrase
end

puts "Please enter the phrase: "
string = gets.chomp

puts "And know the offset number: "
offset = gets.chomp.to_i


transformed_phrase = caesar_transformation(string,offset)

puts "Your transformed phrase is: \n #{transformed_phrase}"

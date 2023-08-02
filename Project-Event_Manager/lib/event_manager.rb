require 'csv'

def clean_zipcode(zipcode)

  #Cleans the zipcode for the three cases presented within the data
  #if zipcode.nil?
  #  zipcode = '00000'
  #elsif zipcode.length < 5
  #  zipcode = zipcode.rjust(5, '0')
  #elsif zipcode.length > 5
  #  zipcode = zipcode[0..4]
  #end

  #But we can implement more succinct, like this:
  zipcode.to_s.rjust(5, '0')[0..4]

end

def main

  puts 'Event Manager Initialized!'

  contents = CSV.open('event_attendees.csv', headers: true, header_converters: :symbol)

  contents.each do |row|
    name = row[:first_name]
    zipcode = row[:zipcode]

    zipcode = clean_zipcode(zipcode)

    puts "#{name} | #{zipcode}"
  end

end

main

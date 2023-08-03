require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

def clean_zipcode(zipcode)
  # Cleans the zipcode for the three cases presented within the data
  # if zipcode.nil?
  #  zipcode = '00000'
  # elsif zipcode.length < 5
  #  zipcode = zipcode.rjust(5, '0')
  # elsif zipcode.length > 5
  #  zipcode = zipcode[0..4]
  # end

  # But we can implement more succinct, like this:
  zipcode.to_s.rjust(5, '0')[0..4]
end

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    legislators = civic_info.representative_info_by_address(address: zipcode, levels: 'country', roles: ['legislatorUpperBody', 'legislatorLowerBody'])
    legislators = legislators.officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end


end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end


def clean_telephone(telephone_number)
  telephone_number.scan(/\d+/).join('')
end



def main
  puts 'Event Manager Initialized!'

  template_letter = File.read('form_letter.erb')
  erb_template = ERB.new template_letter

  contents = CSV.open('event_attendees.csv', headers: true, header_converters: :symbol)

  %{contents.each do |row|
    id = row[0]
    name = row[:first_name]
    zipcode = row[:zipcode]

    zipcode = clean_zipcode(zipcode)

    legislators = legislators_by_zipcode(zipcode)

    form_letter = erb_template.result(binding)
    save_thank_you_letter(id, form_letter)


  end}

  contents.each do |row|
    telephone = row[:homephone]
    puts telephone[0]
    puts  "#{clean_telephone(telephone)}, length: #{clean_telephone(telephone).length}"
  end

end

main

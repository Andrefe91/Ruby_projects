require 'csv'
require 'google/apis/civicinfo_v2'

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

    legislator_names = legislators.map(&:name)

    legislator_string = legislator_names.join(", ")

  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end

  legislator_string
end

def main
  puts 'Event Manager Initialized!'

  contents = CSV.open('event_attendees.csv', headers: true, header_converters: :symbol)

  contents.each do |row|
    name = row[:first_name]
    zipcode = row[:zipcode]

    zipcode = clean_zipcode(zipcode)

    legislators = legislators_by_zipcode(zipcode)

    puts "#{name} | #{zipcode} | #{legislators}"
  end
end

main

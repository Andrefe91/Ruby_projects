require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'time'
require 'date'

civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

def clean_zipcode(zipcode)
  # Cleans the zipcode for the three cases presented within the data
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
  #Saving the files to disk
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end


def valid_telephone_number(telephone_number)
  #Filtering the phone number for only valid ones
  telephone_number = telephone_number.scan(/\d+/).join('')

  if telephone_number.length == 10
    telephone_number
  elsif telephone_number.length == 11 && telephone_number[0] == 1
    telephone_number[1,telephone_number.length-1]
  else
    "invalid"
  end
end

def registry_hour(registry)
  #Returns the hour from the text given in database
  hour = Time.parse(registry.split(' ')[1])
  hour.strftime("%H:00")
end

def day_from_date(date)
  #Calculates the day from the date given. The date it's supposed to be formatted like Year/Day/Month
  Date::DAYNAMES[Date.strptime(date, "%y/%d/%m").wday]
end

def main
  puts 'Event Manager Initialized!'
  registry_hours = []
  registry_days = []

  #I/O of files
  template_letter = File.read('form_letter.erb')
  erb_template = ERB.new template_letter

  contents = CSV.open('event_attendees.csv', headers: true, header_converters: :symbol)

  contents.each do |row|
    #Reading the information
    id = row[0]
    name = row[:first_name]
    zipcode = row[:zipcode]

    #Cleaning the zipcodes
    zipcode = clean_zipcode(zipcode)
    telephone = valid_telephone_number(row[:homephone])

    #Using the Google Civic Api, we retrieve the representative/s by zipcode
    legislators = legislators_by_zipcode(zipcode)

    #Modify template and save to disk for every person on list
    form_letter = erb_template.result(binding)
    save_thank_you_letter(id, form_letter)

    #Calculate the frecuency of hours and days of registries.
    registry_hours.push(registry_hour(row[:regdate]))
    registry_days.push(day_from_date(row[:regdate]))
  end

  #Calculates the number of repeating hours and filter the maximum values
  puts "The hours with more registries are:"
  count_hours = registry_hours.tally
  p count_hours.select {|key, value| value == count_hours.values.max }
  
  puts "Recount of the days with a valid registry:"
  p registry_days.tally


end

main

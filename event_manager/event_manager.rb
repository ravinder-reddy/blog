# Dependencies
require "csv"

# Class Definition
class EventManager
  INVALID_ZIPCODE = "00000"
  INVALID_PHONE = "0000000000"
  def initialize
    puts "EventManager Initialized."
    filename = "event_attendees.csv"
    @file = CSV.open(filename, {headers: true, header_converters: :symbol})
  end


  def print_names
    @file.each do |line|
   	  puts line.inspect
      #puts line[2]
    end
  end

  def print_numbers
  	@file.each do |line|
      number = line[:homephone]
      #clean_number = number.delete!("-")
      #clean_number = number.gsub(/[^0-9]/, '')
      if number.length == 10
		  # Do Nothing
		elsif number.length == 11
		  if number.start_with?("1")
		    number = number[1..-1]
		  else
		    number = INVALID_PHONE
		  end
		else
		  number = INVALID_PHONE
		end
		number = clean_number(line[:homephone])
        puts number
    end
  end

  def clean_number(orginal)
  	number = orginal.gsub(/[^0-9]/,'')
  	return number  # Send the variable 'number' back to the method that called this method
  end

  def print_zipcodes
    @file.each do |line|
      zipcode = clean_zipcode(line[:zipcode])
      puts zipcode
    end
  end

  def clean_zipcode(orginal)
  	if orginal.nil?
      result = INVALID_ZIPCODE  # If it is nil, it's junk
  	elsif orginal.length < 5
  		result =  "%05d" % orginal
  	else
  		result = orginal
  	end
  end

  def output_data
    output = CSV.open("event_attendees_clean.csv", "w")
    @file.each do |line|
      output << line
    end
  end

end

# Script
manager = EventManager.new
#manager.print_names
#manager.print_numbers
#manager.print_zipcodes
manager.output_data

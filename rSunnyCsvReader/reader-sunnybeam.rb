require 'date' 

filename = 'sunnybeam.csv'
 file = File.new(filename, 'r')
   
 text = file.read
    
 text.split("\n") do |row|
	puts row
	puts i
 end   

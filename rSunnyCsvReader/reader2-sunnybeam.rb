require 'csv'

text = File.open('sunnybeam.csv','r')

CSV.parse(text,:col_sep => ";") do |row|
 p row
end
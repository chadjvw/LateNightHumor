require 'sqlite3'
require 'date'
require 'Nokogiri'

# open the file
opendoc = File.open('jokes_to_be_updated.html','r')
# read each file into nokogiri
doc = Nokogiri::HTML(opendoc)

# set the db. jokes.sqlite is in the same folder as this file.
db = SQLite3::Database.open 'jokes.sqlite'

# iterate through each <docfull> tag and do this. this is now a nokogiri document
doc.css('docfull').each do |this|
	# insert data into the docfull table. convert this to string.
	db.execute( "insert into docfull values ( ? )", [this.to_s])
end
require 'sqlite3'
require 'date'
require 'Nokogiri'

# open the first file
opendoc1 = File.open('jokes_to_be_updated.html','r')
# open the second file
opendoc2 = File.open('jokes_to_be_updated2.html','r')
# read each file into nokogiri
doc1 = Nokogiri::HTML(opendoc1)
doc2 = Nokogiri::HTML(opendoc2)

# set the db. jokes.sqlite is in the same folder as this file.
db = SQLite3::Database.open 'jokes.sqlite'

# iterate through each <docfull> tag and do this. this is now a nokogiri document
doc1.css('docfull').each do |this|
	# insert data into the docfull table. convert this to string.
	db.execute( "insert into docfull values ( ? )", [this.to_s])
end

# # do it again
# doc2.css('docfull').each do |this|
# 	# insert data into the docfull table. convert this to string.
# 	db.execute( "insert into docfull values ( ? )", [this.to_s])
# end
require 'Nokogiri'
require 'date'
require 'sqlite3'



doc1 = File.open('jokes_to_be_updated.html','r').read
doc = Nokogiri::HTML(doc1)

i = 0
b = 0
# doc.css('docfull').each do |this|
# 	i += 1
# 	if this.css('p.date')
# 		b += 1
# 	end
# 	# puts this.text
# 	# puts this.css('p.comedian').text
# 	# puts this.css('p.joke').text
# end
# puts 'docfull ' + i.to_s + ' ' + b.to_s

# a = 0
# b = 0
# doc.css('p.date').each do |this|
# 	puts Date.parse(this.text)
# 	a +=1
# 	# puts this.text
# 	# puts this.css('p.comedian').text
# 	# puts this.css('p.joke').text
# end
# puts 'date ' + a.to_s + ' ' + b.to_s





# set the db. jokes.sqlite is in the same folder as this file.
db = SQLite3::Database.open 'jokes.sqlite'

# prepare db with select statement
stm = db.prepare "SELECT * FROM docfull" 
# execute the select. rs now has all the records
rs = stm.execute 

# for each record do row.
rs.each do |row|
	# row is an array with row data. so row[0] hold data from the first colum
	# make nokogiri parse the data from the docufull table as html
	doc2 = Nokogiri::HTML.parse(row[0], nil, 'UTF-8')
	# parse the date from the p.date field
	date = doc2.css("p.joke p.c9")
	# date = Date.parse(date)
	# initialize vars so we can use them later
	puts date
	joker = ""
	jokee = ""
end
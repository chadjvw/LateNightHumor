require 'sqlite3'
require 'date'
require 'Nokogiri'

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
	date = doc2.css("p.date").text
	puts date.class
	#date = Date.parse(date)
	puts date.class
	puts date
	# initialize vars so we can use them later
	joker = ""
	jokee = ""
	# puts 'test'
	# iterate through each joke div. sets the joke div as joke.
	doc2.css("div.joke").each do |joke|
		# if statement to see if there is more than one part to the joke. used for top ten and some leno stuff
		if joke.css("p.joke").count > 1
			# set p comedian into var
			joker = joke.css("p.comedian").text
			# strip : and space from name
			joker = joker.sub(/(:|: )/,'')
			# strip remainting white space
			joker.strip!
			# iterate through joke sub sections. joke2 is now the nokogiri document
			joke.css("p.joke").each do |joke2|
				# set the joke into the var
				jokee = joke2.text
				# chomp off " "
				jokee = jokee.chomp('"')
				jokee = jokee[1..-1]
				# strip white space
				jokee.strip!
				# insert joke into table with all its data. date must be converted to s for some reason
				# db.execute( "insert into jokes values (null, ?, ?, ? )", [date.to_s, joker, jokee])
				# test string to make sure everything is working
				# puts date.to_s + " : " + joker.to_s + " : " + jokee.to_s
			end
		# same as above, except there is only one joke
		elsif joke.css("p.joke").count == 1
			joker = joke.css("p.comedian").text
			joker = joker.sub(/(:|: )/,'')
			joker.strip!
			jokee = joke.css("p.joke").text
			jokee = jokee.chomp('"')
			jokee = jokee[1..-1]
			jokee.strip!
			# db.execute( "insert into jokes values (null, ?, ?, ? )", [date.to_s, joker, jokee])
			# puts date.to_s + " : " + joker.to_s + " : " + jokee.to_s
		end
	end
end
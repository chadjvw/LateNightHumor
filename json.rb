require 'sqlite3'
require 'json'

# set the db. jokes.sqlite is in the same folder as this file.
db = SQLite3::Database.open 'jokes.sqlite'

# prepare db with select statement
stm = db.prepare "SELECT key, cliff FROM jokestwo LIMIT 5" 
# execute the select. rs now has all the records
rs = stm.execute 

i = 0
# for each row
rs.each do |row|
	# get key
	key = row[0]
	# get json, convert to string
	json = row[1].to_s
	puts JSON.parse(json)
	i += 1
end
puts i

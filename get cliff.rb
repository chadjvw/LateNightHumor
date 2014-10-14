require 'rest_client'
require 'sqlite3'
require 'open-uri'

# uri = URI('http://civicdev.media.mit.edu:8080/CLIFF/parse/text?q=This%20should%20be%20a%20story%20about%20S%C3%A3o%20Paulo%20the%20place&replaceAllDemonyms=true')
# res = Net::HTTP.post_form(uri, 'q' => 'ruby', 'max' => '50')
# puts res.body


# set the db. jokes.sqlite is in the same folder as this file.
db = SQLite3::Database.open 'jokes.sqlite'

# prepare db with select statement
stm = db.prepare "SELECT key, joke, cliff FROM jokestwo LIMIT 5" 
# execute the select. rs now has all the records
rs = stm.execute 

i = 0
# for each row
rs.each do |row|
	key = row[0]
	# convert joke to string
	joke = row[1].to_s
	# encode string into url format
	url = URI::encode(joke)
	# get cliff info from MIT
	cliff = RestClient.post 'http://civicdev.media.mit.edu:8080/CLIFF/parse/text?q=' + url + '&replaceAllDemonyms=true', :content_type => :json, :accept => :json
	# insert data back into db
	db.execute( "update jokestwo set cliff = ? where key = ?", [cliff, key])
	i += 1
	puts i
end
puts i

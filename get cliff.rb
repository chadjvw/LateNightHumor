require 'rest_client'
require 'sqlite3'
require 'open-uri'

# uri = URI('http://civicdev.media.mit.edu:8080/CLIFF/parse/text?q=This%20should%20be%20a%20story%20about%20S%C3%A3o%20Paulo%20the%20place&replaceAllDemonyms=true')
# res = Net::HTTP.post_form(uri, 'q' => 'ruby', 'max' => '50')
# puts res.body


# set the db. jokes.sqlite is in the same folder as this file.
db = SQLite3::Database.open 'jokes.sqlite'

# prepare db with select statement
stm = db.prepare "SELECT joke, cliff FROM jokestwo LIMIT 5" 
# execute the select. rs now has all the records
rs = stm.execute 

rs.each do |row|
	joke = row[0].to_s
	puts joke
	url = URI::encode(joke)
	puts url
	cliff = RestClient.post 'http://civicdev.media.mit.edu:8080/CLIFF/parse/text?q=' + url + '&replaceAllDemonyms=true', :content_type => :json, :accept => :json
	puts cliff
end


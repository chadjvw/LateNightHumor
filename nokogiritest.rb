require 'Nokogiri'
require 'date'



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



# open the file to be appended
to_append = File.read("jokes_to_be_updated2.html")
# append weird section to main section
File.open("jokes_to_be_updated.html", "a") do |handle|
  handle.puts to_append
end
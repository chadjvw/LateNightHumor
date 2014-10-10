require 'fileutils'
require 'tempfile'

# temp file name vars
temp_file = Tempfile.new('temp.html')
j_file = Tempfile.new("joke_temp.html")
s_file = Tempfile.new("section_temp.html")


# open the file and tell it to do something. swap is now = to file
File.open('all.html', 'r') do |swap|
	# for each line do line. line is now the individual line from the file
	swap.each_line do |line|
		# this one sets up the p class for the date
		test = line.sub('<DIV CLASS="c3"><P CLASS="c1"><SPAN CLASS="c4">','<P CLASS="date">')
		# removes the day from the date
		test = test.sub(/,\s(?:Mon|Tues|Wednes|Thurs|Fri|Satur|Sun)day/, "")
		test = test.sub(/\s(?:Mon|Tues|Wednes|Thurs|Fri|Satur|Sun)day<\/SPAN><\/P>/, "</P>")
		# removes the html comment code and enables xml parsing
		test = test.sub(/<!--/,'')
		# sets up the joke p class for the old section of the jokes
		test = test.sub(/<P\sCLASS="c8"><SPAN\sCLASS="c2">\s/,'<P CLASS="joke">')
		# sets up the comedian p class for the old section of jokes
		test = test.sub(/<P\sCLASS="c8"><BR><SPAN\sCLASS="c2">/,'</DIV><DIV CLASS="joke"><P CLASS="comedian">')
		# if statement for to find comedians and set the p class to that comedian for newer jokes
		if line.match(/<P CLASS="c9"><SPAN CLASS="c2">\w+\s(O'|)\w+:(| )<\/SPAN><\/P>/)
			line.match(/\w+\s(O'|)\w+:(| )/) do |rec|
				test = line.gsub(/\w+\s(O'|)\w+:(| )/,'</P></DIV><DIV CLASS="joke"><P CLASS="comedian">' + rec.to_s + '</P>')
			end
		end
		# this finds the end of the joke in the newer css and sets it as a joke p class.
		test = test.sub(/<\/P><\/SPAN><\/P>/,'</P><P CLASS="joke">')
		# this one collects top ten and sets them to letterman
		test = test.sub(/<P\sCLASS="c9"><SPAN\sCLASS="c2">\d\.\s/,'</DIV><DIV CLASS="joke"><P CLASS="comedian">David Letterman:</P><P CLASS="joke">')
		# write all the things down
		temp_file.puts test
	end
end

# always close
temp_file.close

# rename from temp to final
File.rename(temp_file.path, 'jokes_to_be_updated.html')

# the section for the section
File.open('section.html', 'r') do |swap|
	swap.each_line do |line|
		test = line
		# this one sets up the p class for the date on the weird section
		if line.match(/<DIV CLASS="c3"><P CLASS="c1"><SPAN CLASS="c2">/)
			line.match(/[A-Za-z]+\s+[0-9]{1,2},\s*[0-9]{4}/) do |rec|
				test = line.sub(/[A-Za-z]+\s+[0-9]{1,2},\s*[0-9]{4}/,'<P CLASS="date">' + rec.to_s + '</P>')
			end
		end
		# removes the html comment code and enables xml parsing
		test = test.sub(/<!--/,'')
		# if statment to fix the huge block crap from when bulletin didnt do things right
		if line.match(/\w+\s(O'|)\w+:(| )/)
			line.match(/\w+\s(O'|)\w+:(| )/) do |rec|
				# one line stop shop to set up the needed classes
				test = line.gsub(/\w+\s(O'|)\w+:(| )/,'</P></DIV><DIV CLASS="joke"><P CLASS="comedian">' + rec.to_s + '</P><P CLASS="joke">')
			end
		# does the same sort of thing with another section
		elsif line.match(/&quot;(\s|)\w+\s(O'|)\w+:(| )<\/SPAN><\/P>/)
			line.match(/&quot;(\s|)\w+\s(O'|)\w+:(| )<\/SPAN><\/P>/) do |rec|
				# same one stop shop line
				test = line.gsub(/&quot;(\s|)\w+\s(O'|)\w+:(| )<\/SPAN><\/P>/,'</P></DIV><DIV CLASS="joke"><P CLASS="comedian">' + rec.to_s + '</P><P CLASS="joke">')
			end
		end
		#test = test
		s_file.puts test
	end
end

# rename from temp to final
File.rename(s_file.path, 'jokes_to_be_updated2.html')

# always close
s_file.close

# for some reason this wont let me do these in the block with the rest so they are here.
File.open('jokes_to_be_updated2.html', 'r') do |swap|
	swap.each_line do |line|	
		test = line.sub(/<\/SPAN><\/P>\n/,'')
		test = test.sub(/<P CLASS="c(8|9)"><SPAN CLASS="c2">/,'')
		#test2 = test2.sub(/<BR><DIV CLASS="c4"><P CLASS="c5"><SPAN CLASS="c7">/,'</P>')
		j_file.puts test
	end
end


File.rename(j_file.path, 'jokes_to_be_updated2.html')

j_file.close

# appeend jokes 2 onto jokes
to_append = File.read("jokes_to_be_updated2.html")
File.open("jokes_to_be_updated.html", "a") do |handle|
  handle.puts to_append
end
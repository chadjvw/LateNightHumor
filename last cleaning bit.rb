require 'tempfile'

t_file = Tempfile.new("another_temp.html")

# WHY DO I HAVE TO BREAK THIS UP?!
# for some reason this wont let me do these in the block with the rest so they are here.
File.open('jokes_to_be_updated.html', 'r') do |swap|
	swap.each_line do |line|
		test = line.gsub(/<P\sCLASS="c9"><SPAN\sCLASS="c2">/," ")
		t_file.puts test
	end
end

FileUtils.mv(t_file.path, 'jokes_to_be_updated.html')

t_file.close


# appeend jokes 2 onto jokes
to_append = File.read("jokes_to_be_updated2.html")
File.open("jokes_to_be_updated.html", "a") do |handle|
  handle.puts to_append
end
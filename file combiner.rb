# Iterates over files and subdirectories in directorie[s] given as arguments
# and adds raw text of those files to merged.txt in the working directory
# where the script is called

# Call like this:
# ruby merge.rb {absolute path portion to delete} {directory to scan} [{directory to scan}]
# For example:
# ruby merge.rb /Users/donnieclapp/Projects/ ~/Projects/htl-website/myproject/static_media/stylesheets

# create or open the merged.txt file for writing (in working directory)
File.open('merged.html','a') do |mergedFile|
  filesInDir = ['jokes_to_be_updated.html','jokes_to_be_updated2.html']
  filesInDir.each do |file|
    # add a header to merged.txt with the relative path of that file
    # (removing first argument given to script)
    puts "processing: #{file}"
    # open the current file and add each line to merged.txt
    text = File.open(file, 'r').read
    text.each_line do |line|
      mergedFile << line
    end
  end
end
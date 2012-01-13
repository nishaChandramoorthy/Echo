require 'rubygems'
require 'json'
require 'mongo'
require 'guid'

@db = Mongo::Connection.new.db("echo")
@books = Hash.new

file = File.new("bookInfo.txt", "r")
counter = 0
result = []
while( line = file.gets)
  puts line.strip!
  h = Hash.new
  line.split("\" , \"").each do  |entry| 

    if(entry.split(" : ")[0].gsub!("\"", "") == 'mainCategory')
      h2 = Array.new
      entry.split(" : ")[1].gsub!("\"", "").split("\/").each do |e|
        e.strip!
        h2 << e
      end
      h[entry.split(" : ")[0].gsub!("\"", "")] = h2
    elsif(entry.split(" : ")[0].gsub!("\"", "") == 'categories')
      val =  entry.split(" : ")[1].gsub!("\"", "")
      val.gsub!("[", "").gsub!("]", "").gsub!("\\\/", "").gsub!("\\", "")
      h2 = Array.new
      val.split(",").each do |a|
        h2 << a
      end
      h[entry.split(" : ")[0].gsub!("\"", "")] = h2 
    elsif(entry.split(" : ")[0].gsub!("\"", "") == 'authors')
      val =  entry.split(" : ")[1].gsub!("\"", "").gsub!("[", "").gsub!("]", "").gsub!("\\", "")
      h['authors'] = val
    else
      h[entry.split(" : ")[0].gsub!("\"", "")] = entry.split(" : ")[1].gsub!("\"", "")
    end
  end
  counter = counter + 1
  result << h
  puts h
end

file.close
puts counter

@coll = @db.collection("books")
a = "/home/neeraj/Desktop/Echo/Books/"

result.each do |entry|
  next if entry["localFileName"] == nil
  key = entry["localFileName"].gsub!(a, "")
  key.gsub!(".pdf", ".txt")
  @books["#{key}"] = entry["uuid"]
end

puts @books

o_file = File.new("/home/sdslabs/EchoInstallations/cluster.txt", "w")

Dir.foreach("/home/sdslabs/EchoInstallations/New") do |item|
  next if item == ".." or item == "."
  file = File.new("/home/sdslabs/EchoInstallations/New/" + item )
  while( line = file.gets )
    puts ":#{line}:"
    o_file.write(line)
    o_file.write(" " )
    o_file.write(Guid.new)
    doc = { "clusterId" => Guid.new.to_s, "bookId" => @books[line] }
    puts doc
  end
end

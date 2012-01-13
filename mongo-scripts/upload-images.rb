require 'rubygems'
require 'json'
require 'mongo'

@db = Mongo::Connection.new.db("echo")

file = File.new("Info.txt", "r")
counter = 0
result = []
while( line = file.gets)
  puts line.strip!
  h = Hash.new
  line.split("\" , \"").each do  |entry| 

    if(entry.split(" : ")[0].gsub("\"", "") == 'mainCategory')
      h2 = Array.new
      entry.split(" : ")[1].gsub("\"", "").split("\/").each do |e|
        e.strip!
        h2 << e
      end
      h[entry.split(" : ")[0].gsub("\"", "")] = h2
    elsif(entry.split(" : ")[0].gsub!("\"", "") == 'categories')
      val =  entry.split(" : ")[1].gsub!("\"", "")
      val.gsub!("[", "")
      val.gsub!("]", "")
      val.gsub!("\\\/", "")
      val.gsub!("\\", "")
      h2 = Array.new
      val.split(",").each do |a|
        h2 << a
      end
      h[entry.split(" : ")[0].gsub("\"", "")] = h2 
    elsif(entry.split(" : ")[0].gsub("\"", "") == 'authors')
      val =  entry.split(" : ")[1].gsub("\"", "").gsub("[", "").gsub("]", "").gsub("\\", "")
      h['authors'] = val
    else
      h[entry.split(" : ")[0].gsub("\"", "")] = entry.split(" : ")[1].gsub("\"", "")
    end
  end
  counter = counter + 1
  result << h
  puts h
end

file.close
puts counter

@coll = @db.collection("books")

result.each do |entry|
  @coll.insert(entry)    
end

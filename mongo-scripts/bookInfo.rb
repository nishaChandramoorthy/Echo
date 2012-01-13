require 'rubygems'
require 'json'
require 'mongo'
require 'guid'

@db = Mongo::Connection.new.db("echo")
@books = Hash.new

file = File.new("Info.txt", "r")
counter = 0
result = []
while( line = file.gets)
  line.strip!
 res=Hash.new
  h = Hash.new
  line.split("\" , \"").each do  |entry| 

    if(entry.split(" : ")[0].gsub!("\"", "") == 'mainCategory')
      h2 = Array.new
      entry.split(" : ")[1].gsub!("\"", "").split("\/").each do |e|
        e.strip!
        h2 << e
      end
      #h[entry.split(" : ")[0].gsub!("\"", "")] = h2
    #elsif(entry.split(" : ")[0].gsub!("\"", "") == 'categories')
     # val =  entry.split(" : ")[1].gsub!("\"", "")
      #val.gsub!("[", "").gsub!("]", "")
      #val.gsub!("\\\/", "")
      #val.gsub!("\\", "")
      #h2 = Array.new
      #val.split(",").each do |a|
       # h2 << a
      #end
      #h[entry.split(" : ")[0].gsub!("\"", "")] = h2 
    elsif(entry.split(" : ")[0].gsub!("\"", "") == 'authors')
      val =  entry.split(" : ")[1].gsub!("\"", "")
      val.gsub!("[", "")
      val.gsub!("]", "")
      val.gsub!("\\", "")
      h['authors'] = val
      res['authors']=val
    elsif(entry.split(" : ")[0].gsub!("\"", "") == 'title')
      
      val =  entry.split(" : ")[1]
      val.gsub!("\"", "")
      val.gsub!("[", "")
      val.gsub!("]",    "")
      val.gsub!("\\", "")
       res['title']=val
    elsif(entry.split(" : ")[0].gsub!("\"", "") == 'small')
      val =  entry.split(" : ")[1]
      res['thumbnail']=val
    else
      res[entry.split(" : ")[0].gsub!("\"", "")] = entry.split(" : ")[1].gsub!("\"", "")
    end
  end
  counter = counter + 1
  
   result<<res
end

file.close


@coll = @db.collection("reccluster")
a = "/home/neeraj/Desktop/Echo/Books/"
@authors= Hash.new
@small=Hash.new
@title=Hash.new
result.each do |entry|
  entry.strip!
  next if entry["localFileName"] == nil
  key = entry["localFileName"].gsub!(a, "")
  key.gsub!(".pdf", ".txt")

  @books["#{key}"] = entry["uuid"]
  @authors["#{key}"]=entry["authors"]
  @small["#{key}"]=entry["thumbnail"]
  @title["#{key}"]=entry["title"]  
            
end

final_result= Hash.new
o_file = File.new("/home/sdslabs/EchoInstallations/reccluster.txt", "w")
@cluster = @db.collection("reccluster")

Dir.foreach("/home/sdslabs/EchoInstallations/New") do |item|
    next if item == ".." or item == "."
    file = File.new("/home/sdslabs/EchoInstallations/New/" + item )
      while( line = file.gets )
          puts ":#{line}:"
              o_file.write(line)
              o_file.write(" " )
              o_file.write(Guid.new)
              line.strip!
              line.gsub! ".txt", ".pdf"
                  if( @books[line] != nil )
                        id = Guid.new
                        id = id.to_s + "a"
                        item.gsub! ".txt", ""
            doc = { "clusterId" => item, "bookId" => @books[line],"title" => @title[line], "authors" =>@authors[line],"thumbnail" => @small[line] }
            puts doc
            @cluster.insert(doc)
                                                                               end
                                        end
end


                                     






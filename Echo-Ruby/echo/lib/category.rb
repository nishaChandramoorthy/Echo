require 'rubygems'
require 'singleton'
require 'mongo'
require 'json'

class EchoCategory
  include Singleton

  def initialize()
    @db = Mongo::Connection.new.db("echo")
    @coll = @db.collection("categoryList")
    @result = []
  end

  def getBookList(cat)
    cat.downcase!
    p cat
    @coll = @db.collection("categories")
    query = {"category" => cat}
    cursor = @coll.find(query)
    @result = Array.new
    if cursor.has_next? == false
      p "if not theri" + @result.to_s
      return 
    end
    tempCat = cursor.next
    bookList = tempCat["list"]
    @db = Mongo::Connection.new.db("echo")
    @coll = @db.collection("books")
    bookList.each{ |book|
      map = Hash.new
      book.strip!
      query = {"uuid" => book}
      cursor = @coll.find(query)
      if !cursor.has_next?
        next
      end
      doc = cursor.next
      doc.each do |key, value|
        if key == "title" or key == "authors" or key == "thumbnail"
          if key == "thumbnail"
            key = "small"
            map[key] = "images/" + doc["uuid"]
          else
            map[key] = value
          end        
        elsif key == "description"
          map[key] = value[0,300] + "..."
        end
      end
      map["uuid"] = book
      @result <<  map
    }
  end

  def getJSON()
    @result.to_json()
  end

end


CATEGORY = EchoCategory.instance

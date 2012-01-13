require 'rubygems'
require 'singleton'
require 'mongo'
require 'json'

class EchoCategorySearch
  include Singleton

  def initialize()
    @db = Mongo::Connection.new.db("echo")
    @coll = @db.collection("categoryList")
    @result = []
  end

  def getCategoryResult(query)
    @result = Array.new
    p @result
    counter = 0
    p query
    query.split(' ').each{ |tempQuery|
      s = tempQuery.length     
      n = s
      while n > 2
        (1..s-n+1).each{ |m|
          newQuery = tempQuery[m-1, n]
          cursor = @coll.find({"id" => newQuery})
          if cursor.has_next? == true
            doc = cursor.next
            @result = @result | doc["list"]
            counter += 1
          end
       }
        if counter > 0
         break
        end
        n = n-1
      end
    }
    p @result.inspect
  end

  def getJSON()
    @result.to_json()
  end

end


CATEGORY_SEARCH = EchoCategorySearch.instance

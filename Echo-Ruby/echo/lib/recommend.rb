require 'singleton'
require 'mongo'

class EchoRecommender
  include Singleton

  def initialize()
    @db = Mongo::Connection.new(SETTINGS.getMongoIP,SETTINGS.getMongoPort).db('echo')
    @book = @db.collection('reccluster')
  end

  def fillInResults(bookids)
    puts bookids
    @results = []
    bookids.each{ |bookid| 
      bookid.strip!
      doc = @book.find("uuid" => bookid).first
      doc["thumbnail"] = "images/" + doc["uuid"]
      doc["small"] = "images/" + doc["uuid"]
      @results << doc
    }
    puts @results
  end

  def getSimilarBooks(uuid)
    @cluster = @db.collection('reccluster')
    recommendedBookIds = []
    @cluster.find("uuid" => uuid).each{ |c| @clusterId = c}
    puts @clusterId
    @cluster.find("clusterId" => @clusterId["clusterId"]).each{ |doc| 
      recommendedBookIds << doc["uuid"] 
    } 
    fillInResults(recommendedBookIds)
  end   

  def view()
    @view.render('recommend', self)
  end

  def getJSON()
    @results.to_json()
  end
end         

RECOMMEND = EchoRecommender.instance



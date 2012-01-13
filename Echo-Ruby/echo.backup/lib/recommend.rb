require 'singleton'
require 'mongo'

class EchoRecommender
  include Singleton

  def initialize()
    @db = Mongo::Connection.new(SETTINGS.getMongoIP,SETTINGS.getMongoPort).db('echo')
    @book = @db.collection('books')
  end

  def fillInResults(bookids)
    puts bookids
    @results = []
    bookids.each{ |bookid| 
      bookid.strip!
      @results << @book.find("uuid" => bookid).first
    }
  end

  def getSimilarBooks(uuid)
    @cluster = @db.collection('cluster')
    recommendedBookIds = []
    @cluster.find("bookId" => uuid).each{ |c| @clusterId = c}
    puts @clusterId
    @cluster.find("clusterId" => @clusterId["clusterId"]).each{ |doc| 
      recommendedBookIds << doc["bookId"] 
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



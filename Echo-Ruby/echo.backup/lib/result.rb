require 'haml'
require 'viewHelper.rb'
require 'singleton'
require 'settings.rb'
require 'rest_client'
require 'mongo'
require 'uri'

class EchoResult 
  include Singleton

  def initialize()
    @view = ViewHelper.new()
  end

  def fillInResults(bookids)
    db = Mongo::Connection.new(SETTINGS.getMongoIP, SETTINGS.getMongoPort).db('echo')
    @book = db.collection('books')
    @results = []
    counter = 0
    bookids.each{ |bookid| 
      counter = counter + 1
      next if counter > 60 
      book = @book.find(:uuid => bookid).first
      h = Hash.new
      h["uuid"] = book["uuid"]
      h["title"] = book["title"]
      h["small"] = book["small"]
      if(book["description"] != nil)
        h["description"] = book["description"][0, 200] + "..."
      else
        h["description"] = "Description not available ! :("
      end
      h["authors"] = book["authors"]
      @results << h
    }
  end
  
  def getEchoResult(query)
    url = SETTINGS.getScalaIP + ":" + SETTINGS.getScalaPort + "/" + "?query=" + URI.escape(query)
    bookids = []
    res = RestClient.get(url){ |response, request, result, &block|
                               case response.code
                               when 200
                                 result = JSON.parse(response.body)
                                 result.each{ |bookid| bookids << bookid }
                               end
    }
    
    fillInResults(bookids)
  end
  
  def view()
    @view.render('result', self) 
  end

  def getJSON()
    @results.to_json()  
  end

end

RESULT = EchoResult.instance

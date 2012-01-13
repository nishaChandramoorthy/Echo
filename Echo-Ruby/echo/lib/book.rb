require 'singleton'
require 'haml'
require 'mongo'

class Book
  include Singleton

  def initialize()
    @view = ViewHelper.new()
    @db = Mongo::Connection.new(SETTINGS.getMongoIP, SETTINGS.getMongoPort).db('echo')
    @detail = Hash.new
  end                                
                                     
  def getDetails(id)                 
    @book = @db.collection('tbooks')  
    @results = Hash.new              
    d = @book.find(:uuid => id).first
    @detail["authors"] = d["authors"]
    @detail["title"] = d["title"]    
    @detail["small"] = "images/" + d["uuid"]
    @detail["description"] = d["description"]
    @detail["categories"] = d["categories"]
    @detail["id"] = d["uuid"]
    @detail["rating"] = d["averageRating"]
    @detail["publisher"] = d["publisher"]
    @detail["pageCount"] = d["pageCount"]
    @detail["mainCategories"] = d["mainCategory"]
    @detail["subtitle"] = d["subtitle"]
  end

  def view()
    getDetail()
    @view.render('detail', self)
  end

  def getJSON()
    @detail.to_json()
  end

end

BOOK = Book.instance


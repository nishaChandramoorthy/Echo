require 'sinatra'
require 'mongo'
require 'haml'


  

  def getSimilarBooks(uuid)
    db = Mongo::Connection.new('127.0.0.1',27017).db('echo')
    @book = db.collection('book')
     res = []
    @book.find({"id" => uuid}).each{
                                      |doc| @book.find({"cluster" => doc['cluster']}, :fields => ["id"] ).
                                      each{
                                        |b|
                                        res.push(b)
                                      }
                                  }
                                  p res
                                  return res
                        
                            end
                    )
         

  end




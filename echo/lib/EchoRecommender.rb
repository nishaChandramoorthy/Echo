
require 'mongo'


  

  def getSimilarBooks(uuid)
    db = Mongo::Connection.new('127.0.0.1',27017).db('echo')
    @book = db.collection('book')
     res = []
    @book.find({"uuid" => uuid}).each{
                                      |doc| @book.find({"cluster" => doc['cluster']}, :fields=>["uuid"]).
                                      each{
                                        |b|
                                        res.push(b)
                                      }
                                  }
                                  p res
                                  return res
                        
                            end
                  
         

  




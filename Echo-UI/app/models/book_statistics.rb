class BookStatistics
  include Mongoid::Document
  
  field :popular_books, type: Array
  field :books_currently_read, type: Array

end

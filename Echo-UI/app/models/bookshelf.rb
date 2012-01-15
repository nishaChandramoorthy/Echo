class Bookshelf
  include Mongoid::Document

  field :name, type:String
  field :book_ids, type: Array
  field :private, type: Boolean

end

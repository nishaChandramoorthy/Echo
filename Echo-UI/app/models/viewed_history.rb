class ViewedHistory
  include Mongoid::Document
  include Mongoid::Timestamp

  field :book_ids, type: Array

end

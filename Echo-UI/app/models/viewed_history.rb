class ViewedHistory
  include Mongoid::Document
  include Mongoid::Timestamps

  field :book_ids, type: Array

  embedded_in :user

end

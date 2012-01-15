class SearchHistory
  include Mongoid::Document

  field :search_queries, type: Array
  
  embedded_in :user

end

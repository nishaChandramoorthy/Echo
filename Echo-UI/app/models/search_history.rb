class SearchHistory
  include Mongoid::Document

  field :search_queries, type: Array

end

class Category
  include Mongoid::Document
  include Mongoid::Timestamps
 
  field :id, type: String 
  field :name, type: String

  has_and_belongs_to_many :books
  
  validates :name, presence: true, uniqueness: true
  validates :id, presence: true, uniqueness: true
  
  index "name", background: true
  index "id", background: true
  
end

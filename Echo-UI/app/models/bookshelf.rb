class Bookshelf
  include Mongoid::Document

  field :bookshelf_id, type: String
  field :name, type:String
  field :book_ids, type: Array
  field :private, type: Boolean, default: true

  embedded_in :user

  validates :bookshelf_id, presence: true, uniqueness: true
  validates :name, presence: true

  index "bookshelf_id", background: true
 
  key :bookshelf_id
 
  def to_param
    bookshelf_id  
  end

end

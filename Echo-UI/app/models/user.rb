class User
  include Mongoid::Document
 
  field :user_name, type: String
  field :user_id, type: String
  
  # sdslabs' user id to fetch info for the user
  field :sdslabs_id, type: String

  # Array of book ids that the user liked
  field :likes, type: Array

  # Array of books recommended for user
  field :recommended_books, type: Array

  # Array of recommended bookshelves.
  field :recommended_bookshelves, type: Array 
 
  # Array of read it later books
  field :read_it_later, type: Array
  
  # favourite boooks
  field :favorites, type: Array

  # History of searches
  embeds_many :search_histories, validate: false
  
  # History of viewed books
  embeds_many :viewed_histories, validate: false

  # bookshelf maintained by user
  embeds_many :bookshelves, validate: false

  validates :user_name, presence: true
  validates :user_id, presence: true, uniqueness: true
  validates :sdslabs_id, presence: true,uniqueness: true

  index "user_id", background: true
  index "sdslabs_id", background: true
  
  key :user_id
  
  def to_param
    user_id
  end
  
end

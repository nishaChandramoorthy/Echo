class Book
  include Mongoid::Document
  include Mongoid::Timestamps

  field :book_id, type: String
  field :title, type: String
  field :subtitle, type: String
  field :publisher, type: String
  field :published_date, type: Date
  field :language, type: String
  field :description, type: String
  field :file_name, type: String
  field :isbn_10, type: Integer
  field :isbn_13, type: Integer
  field :authors, type: String
  field :page_count, type: Integer
  field :image_small,type: String
  field :image_large, type: String
  field :likes, type: Integer
  
  # Array of user ids who liked
  field :liked_by, type: Array

  # for randomly selecting books
  field :random, type: Float

  # Array of uuids of similar books..
  field :similar_books, type: String
  
  has_and_belongs_to_many :categories
  
  validates :book_id, presence: true, uniqueness: true
  validates :title, presence: true, uniqueness: true
  validates :publisher, presence: true
  validates :language, presence: true
  validates :file_name, presence: true
  validates :authors, presence: true

  index "uuid", backgorund: true
  index "title", backgound: true

  key :book_id
  
  def to_param 
    book_id
  end
 
end

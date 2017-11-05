class Book < ActiveRecord::Base
  has_many :user_books
  has_many :users, through: :user_books
  has_many :book_genres
  has_many :genres, through: :book_genres
  belongs_to :author
end

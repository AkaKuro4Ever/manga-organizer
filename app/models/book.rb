class Book < ActiveRecord::Base
  has_many :user_books
  has_many :users, through: :user_books
  has_many :genres
  belongs_to :author
end

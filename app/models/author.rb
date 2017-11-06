class Author < ActiveRecord::Base
  has_many :books
  has_many :genres, through: :books

  def self.check(params)
    self.all.find {|author| author.name == params}
  end
end

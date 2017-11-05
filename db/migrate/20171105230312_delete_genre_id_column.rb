class DeleteGenreIdColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :books, :genre_id 
  end
end

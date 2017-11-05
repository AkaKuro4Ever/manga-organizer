class ChangeColumnGenreBooks < ActiveRecord::Migration[5.1]
  def change
    change_column :books, :genre, :integer
    rename_column :books, :genre, :genre_id
  end
end

class AddVolumeColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :volume, :integer
  end
end

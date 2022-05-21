class RenameFavoriteIdColumnToFavorites < ActiveRecord::Migration[6.1]
  def change
    rename_column :favorites, :favorite_id, :book_id
  end
end

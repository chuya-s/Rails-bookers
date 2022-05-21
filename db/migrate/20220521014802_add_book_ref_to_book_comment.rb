class AddBookRefToBookComment < ActiveRecord::Migration[6.1]
  def change
    add_reference :book_comments, :book, null: false, foreign_key: true
  end
end

class AddBookmarkToCards < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :bookmark, :string
  end
end

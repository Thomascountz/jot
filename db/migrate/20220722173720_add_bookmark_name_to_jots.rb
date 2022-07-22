class AddBookmarkNameToJots < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :bookmark_name, :string
    rename_column :cards, :bookmark, :bookmark_url
  end
end

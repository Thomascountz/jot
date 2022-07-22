class AddSlugToCard < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :slug, :string, unique: true
    change_column_null :cards, :body, false
    add_index :cards, :slug
  end
end

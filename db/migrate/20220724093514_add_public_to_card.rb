class AddPublicToCard < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :public, :boolean, default: false
  end
end

class SlugNullConstraint < ActiveRecord::Migration[7.0]
  def change
    change_column_null :cards, :slug, false
  end
end

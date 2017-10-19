class AddCategoryToShops < ActiveRecord::Migration[5.1]
  def change
    add_reference :shops, :category, foreign_key: true, index: true
  end
end

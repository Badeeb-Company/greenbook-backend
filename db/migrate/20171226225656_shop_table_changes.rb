class ShopTableChanges < ActiveRecord::Migration[5.1]

  def change
  	add_column :shops, :google_place_id, :string, index: true
  	remove_column :shops, :description
  end

end

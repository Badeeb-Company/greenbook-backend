class CreateShops < ActiveRecord::Migration[5.1]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :description
      t.float :rate
      t.float :lat
      t.float :long
      t.string :address
      t.string :phone_number
      t.string :main_photo_url

      t.timestamps
    end
  end
end

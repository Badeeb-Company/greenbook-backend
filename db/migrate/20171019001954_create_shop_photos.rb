class CreateShopPhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :shop_photos do |t|
      t.references :shop, foreign_key: true
      t.string :photo_url

      t.timestamps
    end
  end
end

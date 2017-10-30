class CreateShopAdmins < ActiveRecord::Migration[5.1]
  def change
    create_table :shop_admins do |t|
      t.references :shop, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

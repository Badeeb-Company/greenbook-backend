class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :description
      t.integer :rate

      t.references :user
      t.references :shop_owner
      t.references :shop, foreign_key: true
      
      t.string :reply
      t.datetime :date_replied

      t.timestamps
    end
  end
end

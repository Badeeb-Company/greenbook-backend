class AddTokenToUsers < ActiveRecord::Migration[5.1]
  def up
  	add_column :users, :token, :string
    add_index :users, :token, unique: true
  end

  def down
  	remove_index :users, :token
  	remove_column :users, :token
  end
end

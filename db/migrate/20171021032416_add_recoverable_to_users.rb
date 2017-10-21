class AddRecoverableToUsers < ActiveRecord::Migration[5.1]
  def up
  	add_column :users, :reset_password_token, :string
  	add_column :users, :reset_password_sent_at, :datetime
  	add_index :users, :reset_password_token, unique: true
  end

  def down
  	remove_column :users, :reset_password_token
  	remove_column :users, :reset_password_sent_at
  	remove_index :users, :reset_password_token
  end
end

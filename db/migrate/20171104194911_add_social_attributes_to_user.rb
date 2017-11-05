class AddSocialAttributesToUser < ActiveRecord::Migration[5.1]
  def up
  	add_column :users, :account_type, :string
  	add_column :users, :account_id, :string
  	add_column :users, :account_token, :string
  end

  def down
  	remove_column :users, :account_type
  	remove_column :users, :account_id
  	remove_column :users, :account_token
  end
end

class AddDefaultAccountTypeToUser < ActiveRecord::Migration[5.1]
	
  def change
  	change_column :users, :account_type, :string, :default => 'email'
  end

end

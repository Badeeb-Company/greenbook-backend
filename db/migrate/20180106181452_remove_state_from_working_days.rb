class RemoveStateFromWorkingDays < ActiveRecord::Migration[5.1]
  def change
  	remove_column :working_days, :state
  	add_column :working_days, :as_text, :string
  end
end

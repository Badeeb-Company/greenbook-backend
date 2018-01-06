class RemoveClosedAtAndOpenedAtFromWorkingDays < ActiveRecord::Migration[5.1]
  def change
  	remove_column :working_days, :opened_at
  	remove_column :working_days, :closed_at
  end
end

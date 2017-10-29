class ChangeWorkingDayTimeFieldsToDateTime < ActiveRecord::Migration[5.1]
	def change
		remove_column :working_days, :opened_at
		remove_column :working_days, :closed_at
		add_column :working_days, :opened_at, :time
		add_column :working_days, :closed_at, :time
	end
end

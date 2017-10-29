class ChangeWorkingDayTimeFieldsToString < ActiveRecord::Migration[5.1]
  def change
  	change_column :working_days, :opened_at, :string
  	change_column :working_days, :closed_at, :string
  end
end

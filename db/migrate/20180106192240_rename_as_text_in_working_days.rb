class RenameAsTextInWorkingDays < ActiveRecord::Migration[5.1]
  def change
  	rename_column :working_days, :as_text, :opening_hours
  end
end

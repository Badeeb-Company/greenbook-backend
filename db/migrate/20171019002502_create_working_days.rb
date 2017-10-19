class CreateWorkingDays < ActiveRecord::Migration[5.1]
  def change
    create_table :working_days do |t|
      t.string :day_name
      t.integer :opened_at
      t.integer :closed_at
      t.string :state
      t.references :shop, foreign_key: true

      t.timestamps
    end
  end
end

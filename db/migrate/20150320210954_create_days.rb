class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.datetime 'day'
      t.references :timesheet
    end
  end
end

class CreateTimesheet < ActiveRecord::Migration
  def change
    create_table :timesheets do |t|
      t.references :time_period
      t.references :employee
    end
  end
end

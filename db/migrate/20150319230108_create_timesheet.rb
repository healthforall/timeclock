class CreateTimesheet < ActiveRecord::Migration
  def change
    create_table :timesheets do |t|
      t.references :payperiod
      t.references :employee
    end
  end
end

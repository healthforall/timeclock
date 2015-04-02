class ChangePayPeriodToDate < ActiveRecord::Migration
  def up
    change_column :payperiods, :start_date, :date
    change_column :payperiods, :end_date,   :date
  end
  def down
    change_column :payperiods , :start_date, :datetime
    change_column :payperiods, :end_date,   :datetime
  end
end

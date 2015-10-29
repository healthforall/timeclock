class AddApprovedToTimesheets < ActiveRecord::Migration
  def change
    add_column :timesheets, :approved, :boolean
  end
end

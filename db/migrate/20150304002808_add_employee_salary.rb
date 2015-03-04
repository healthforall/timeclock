class AddEmployeeSalary < ActiveRecord::Migration
  def up
    add_column :employees, :salary , :string
  end

  def down
    remove_column :employees, :salary , :string
  end
end

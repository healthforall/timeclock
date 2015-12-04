class ChangeColumnType < ActiveRecord::Migration
  def change
    change_column :vacations, :hours, :string
  end
end

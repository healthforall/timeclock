class AddUid < ActiveRecord::Migration
  def up
    add_index :employees, :uid, :unique =>true
  end

  def down
    remove_column :employees, :uid
  end
end

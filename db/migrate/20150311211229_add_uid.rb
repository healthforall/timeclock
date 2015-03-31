class AddUid < ActiveRecord::Migration
  def change
    add_index :employees, :uid, :unique =>true
  end
end

class AddInAndOutIndex < ActiveRecord::Migration
  def change
    add_index :in_and_outs, :in_time
  end
end

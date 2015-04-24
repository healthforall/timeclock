class AddInAndOutIndex < ActiveRecord::Migration
  def change
    add_index :in_and_outs, :in
  end
end

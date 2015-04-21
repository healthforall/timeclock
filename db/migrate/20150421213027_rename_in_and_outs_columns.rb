class RenameInAndOutsColumns < ActiveRecord::Migration
  def change
    rename_column :in_and_outs, :in_time, :in_time
    rename_column :in_and_outs, :out_time, :out_time
  end
end

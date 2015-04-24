class RenameInAndOutsColumns < ActiveRecord::Migration
  def up
    rename_column :in_and_outs, :in, :in_time
    rename_column :in_and_outs, :out, :out_time
  end

  def down
    rename_column :in_and_outs, :in_time, :in
    rename_column :in_and_outs, :out_time, :out
  end
end

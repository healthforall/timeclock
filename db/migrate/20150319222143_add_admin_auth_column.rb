class AddAdminAuthColumn < ActiveRecord::Migration
  #What the authority be represented as?
  def change
    add_column :employees , :admin, :boolean
  end
end

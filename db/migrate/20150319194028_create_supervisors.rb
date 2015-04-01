class CreateSupervisors < ActiveRecord::Migration
  def change
    create_table :supervisors do |t|
      t.references :employee
      t.references :supervisor
    end
  end
end

class CreateVacations < ActiveRecord::Migration
  def change
    create_table :vacations do |t|
      t.string :name
      t.string :type
      t.datetime :date
      t.integer :hours

      t.timestamps null: false
    end
  end
end

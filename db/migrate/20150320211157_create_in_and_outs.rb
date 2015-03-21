class CreateInAndOuts < ActiveRecord::Migration
  def change
    create_table :in_and_outs do |t|
      t.references :day
      t.datetime 'in'
      t.datetime 'out'
    end
  end
end

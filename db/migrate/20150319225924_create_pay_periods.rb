class CreatePayPeriods < ActiveRecord::Migration
  def change
    create_table :time_periods do |t|
      t.datetime 'start_date'
      t.datetime 'end_date'
    end
  end
end

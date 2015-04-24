class ChangeDayFieldInDaysToDate < ActiveRecord::Migration
    def up
      change_column :days, :day, :date
    end
    def down
      change_column :days , :day, :datetime
    end
end

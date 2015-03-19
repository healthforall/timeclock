class Timesheet < ActiveRecord::Base
  belongs_to :employee
  belongs_to :time_period
end

class PayPeriod < ActiveRecord::Base
  has_many :time_sheets

  def find_time_period(date)
    DateTime.parse(date)


  end
end

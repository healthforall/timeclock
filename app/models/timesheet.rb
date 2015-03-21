class Timesheet < ActiveRecord::Base
  belongs_to :employee
  belongs_to :payperiod
  has_many   :days

  after_initialize :init
  after_create    :make_days

  scope :current, lambda {
      date = Date.today()
      payperiod = Payperiod.find_payperiod(date)
      timesheets = Timesheet.where("payperiod_id = :id" , :id => payperiod.id)
   }


  def init
    #If a timesheet is created without a payperiod assume it is for the current period
    self.payperiod_id ||= Payperiod.find_payperiod(Date.today()).id
  end

  def make_days
    #Create all the days of a timesheet if they don't exist yet
    if (!self.days.blank?)
      return
    end

    payperiod  = Payperiod.find_by_id(self.payperiod_id)
    start_date = payperiod.start_date
    end_date   = payperiod.end_date
    dates = (start_date.to_date..end_date).map{ |date| date}
    dates.each do |day|
      self.days.create!(day: day)
    end

  end
end

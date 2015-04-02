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


  def totalHours
    value = 0.0
    days.each do |day|
      day.in_and_outs.each do |shift|
        if (shift.in and shift.out)
          diff = Time.diff(shift.out , shift.in)
          value += diff[:hour]
          value += (diff[:minute] / 60.0)
        end
      end
    end
    return value
  end

  def clockin?
    iN = false
    self.days.each do |day|
      iN ||= day.clockin?
    end
    return iN
  end

  def init
    #If a timesheet is created without a payperiod assume it is for the current period
    self.payperiod ||= Payperiod.find_payperiod(Date.today())
  end

  def make_days
    #Create all the days of a timesheet if they don't exist yet
    if (!self.days.blank?)
      return
    end

    payperiod  = self.payperiod
    start_date = payperiod.start_date
    end_date   = payperiod.end_date
    dates = (start_date.to_date..end_date).map{ |date| date}
    dates.each do |day|
      self.days.create!(day: day)
    end

  end
end

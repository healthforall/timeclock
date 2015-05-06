class Timesheet < ActiveRecord::Base
  belongs_to :employee
  belongs_to :payperiod
  has_many   :days

  after_initialize :init
  after_create    { |t| t.make_days (false) }
  scope :current, lambda {
      date = Date.today()
      payperiod = Payperiod.find_payperiod(date)
      timesheets = Timesheet.where("payperiod_id = :id" , :id => payperiod.id).includes(:days)
   }


  def totalHours
    value = 0.00
    days.each do |day|
      day.in_and_outs.each do |shift|
        if (shift.in_time and shift.out_time)
          diff = Time.diff(shift.out_time , shift.in_time)
          value += diff[:hour]
          value += (diff[:minute] / 60.00)
        end
      end
    end
    return value.round(2)
  end

  def clockin?
    #iN = false
    #self.days.each do |day|
    #  iN ||= day.clockin?
    #end
    return self.days.current[0].clockin?
  end

  def init
    #If a timesheet is created without a payperiod assume it is for the current period
    self.payperiod ||= Payperiod.find_payperiod(Date.today())
  end

  def make_days( build )
    #Create all the days of a timesheet if they don't exist yet
    if (!self.days.blank?)
      return
    end
    payperiod  = self.payperiod
    start_date = payperiod.start_date
    end_date   = payperiod.end_date
    dates = (start_date.to_date..(end_date )).map{ |date| date}
    dates.each do |day|
      self.days.build(day: day) if build
      self.days.create(day: day ) unless build
    end
  end

  def halves
    i = -1
    length = self.days.length
    self.days.partition { i += 1; i< length / 2}
  end

  def self.verifyAndCreate( days, employee , payperiod)
    @timesheet = employee.timesheets.build(  :payperiod=> payperiod)
    @timesheet.make_days(true)
    days = days["days"]
    days.each_with_index  do | day , i|
      inandouts = day[1]
      inandouts.each do |inandout|
        day = @timesheet.days[i]
        inandout['in'] = DateTime.parse( day.day.to_s + " " + inandout['in']) + 5.hours unless inandout['in'] == ''
        inandout['out'] = DateTime.parse( day.day.to_s + " " + inandout['out']) + 5.hours unless inandout['out'] == ''
        inandout['out'] = nil if inandout['out'] == ''
        @timesheet.days[i].in_and_outs.build( :in_time => inandout['in'] , :out_time => inandout['out'])
      end
    end
    return @timesheet
  end


end

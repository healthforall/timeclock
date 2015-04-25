class Day < ActiveRecord::Base
  belongs_to :timesheet
  has_many   :in_and_outs

  attr_accessor :num
  scope      :current , lambda {
    date = Date.today()
    Day.where("day = :date" , date: date)
  }

  scope      :find_by_date , lambda  { |date|
    Day.where("day = :date" , date: date)
  }

  def clockin?
    if(self.in_and_outs.find_dangling_in[0])
      return true
    else
      return false
    end
  end

  def print
    self.day.strftime("%a %m/%d")
  end

end

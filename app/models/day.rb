class Day < ActiveRecord::Base
  belongs_to :timesheet
  has_many   :in_and_outs

  scope      :current , lambda {
    date = DateTime.parse(Date.today().to_s)
    Day.where("day = :date" , date: date)
  }

  scope      :find_by_date , lambda  { |date|
                               date = DateTime.parse(Date.parse(date.to_s).to_s)
                               Day.where("day = :date" , date: date)
                           }

end

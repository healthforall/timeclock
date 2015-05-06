class Payperiod < ActiveRecord::Base
  has_many :time_sheets

  validates :start_date, :uniqueness => true
  validates :end_date  , :uniqueness => true

  scope :contains_date, lambda { |date|
     Payperiod.where("start_date <= :date AND end_date >= :date" , date: date)[0]
  }


  #
  def self.find_payperiod(date)
    date = Date.parse(date.to_s)
    payperiod = Payperiod.where("start_date <= :date AND end_date >= :date" , date: date)[0]
    if (payperiod)
      return payperiod
    else
      return Payperiod.construct(date)
    end
  end

  def self.construct(date)
    daysinmonth = Time.days_in_month(date.month , date.year )
    days = []
    if date.day <= 15
      days = [ 1 , 15 ]
    else
      days = [ 16 , daysinmonth ]
    end

    start_date = (date - ( date.day.day - days[0].day ))
    end_date   = (date + ( days[1].day - date.day.day ))

    Payperiod.create!( :start_date => start_date , :end_date => end_date)
  end

  def print()
    word = self.start_date.strftime("%B %d - ") + self.end_date.strftime("%d, %Y")
  end

  def file_print()
    word = self.start_date.strftime("%B_%d-") + self.end_date.strftime("%d_%Y")
  end

  def self.all_cache
    self.all
  end

end

class Payperiod < ActiveRecord::Base
  has_many :time_sheets
  validates :start_date, :uniqueness => true
  validates :end_date  , :uniqueness => true
  scope :contains_date, lambda { |date|
     Payperiod.where("start_date <= :date AND end_date >= :date" , date: date)[0]
  }
  def self.find_payperiod(date)
    Payperiod.where("start_date <= :date AND end_date >= :date" , date: date)[0]
  end
end

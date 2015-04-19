FactoryGirl.define do

  factory :timesheet do
    payperiod { Payperiod.find_payperiod(Date.today()) }
    employee
  end

end
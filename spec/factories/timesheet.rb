FactoryGirl.define do

  factory :timesheet do
    payperiod { Payperiod.find_payperiod(Date.today()) }
    employee  { Employee.create!( :uid => -1 , :name => "noOne" , :email => "noOne@gmail.com" ) unless Employee.find_by_name("noOne")}
  end
  #make a factory for employee_without_timesheet
end
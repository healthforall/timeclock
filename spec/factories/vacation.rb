FactoryGirl.define do

  #Vanilla Employee generator they will have a blank timesheet for the current payperiod
  factory :vacation do |f|
    f.name {"Sick Leave"}
    f.type {"1"}
    f.date  {Faker::Date.forward(8)}
    f.hours {1}
    
  end

  factory :invalid_vacation, parent: :vacation do |f|
    f.name nil
  end

  # factory :invalid_contact, parent: :employee do |f|
  #   f.email nil  
  # end  
end

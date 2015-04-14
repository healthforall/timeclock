FactoryGirl.define do

  #Vanilla Employee generator they will have a blank timesheet for the current payperiod
  factory :employee do |f|
    f.name {Faker::Name.name}
    f.email {Faker::Internet.email}
    f.uid {Faker::Internet.password} #password gives a string of letters and numbers

    after(:create) do |employee|
      create(:timesheet, employee: employee)
    end
  end

  factory :invalid_employee, parent: :employee do |f|
    f.name nil
  end
end

FactoryGirl.define do

  #Vanilla Employee generator they will have a blank timesheet for the current payperiod
  factory :employee do
    sequence(:name){ |n| "#{n}" }
    sequence(:email){ |n| "a#{n}@gmail.com"}
    sequence(:uid) { |n| n }
    after(:create) do |employee|
      create(:timesheet, employee: employee)
    end
  end
end

#f.name {Faker::Name.name}
#f.email {Faker::Internet.email}
#f.uid {Faker::Internet.password} #password gives a string of letters and numbers
#sequence(:name) {Faker::Name.name}  #{ |n| "#{n}" }
#sequence(:email) {Faker::Internet.email}  #{ |n| "a#{n}@gmail.com"} #{Faker::Internet.email}
#sequence(:uid) {Faker::Internet.password}  #{ |n| n.to_i }

#sequence(:name) { |n| "#{n}" }
#sequence(:email) { |n| "a#{n}@gmail.com"} #{Faker::Internet.email}
#sequence(:uid) { |n| n }
#after(:create) do |employee|
#  create(:timesheet, employee: employee)
#end
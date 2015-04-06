FactoryGirl.define do
# creates a pay period that starts up to 8 days before today and ends up to 8 days after today

  factory :payperiod do |f|
    f.start_date {Faker::Date.between(8.days.ago, 1.days.ago)}
    f.end_date {Faker::Date.forward(8)}
    #start_date do
     # DateTime.parse("2015-3-1 10:00:00")
    #end

    #end_date do
     # DateTime.parse("2015-3-16 10:00:00")
    #end
  end
end

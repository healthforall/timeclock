FactoryGirl.define do

  factory :payperiod do
    start_date do
      DateTime.parse("2015-3-1 10:00:00")
    end

    end_date do
      DateTime.parse("2015-3-16 10:00:00")
    end
  end
end
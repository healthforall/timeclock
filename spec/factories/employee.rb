FactoryGirl.define do

  factory :employee do
    sequence(:name){ |n| "#{n}" }
    sequence(:email){ |n| "a#{n}@gmail.com"}
    sequence(:uid) { |n| n }
    after(:create) do |employee|
      create(:timesheet, employee: employee)
    end
  end
end
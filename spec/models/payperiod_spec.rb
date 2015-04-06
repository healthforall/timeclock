require 'spec_helper'
require 'factory_girl_rails'


describe Payperiod do
  it "has a valid factory" do
    expect(FactoryGirl.build(:payperiod)).to be_valid
  end

  # do we need to check uniqueness ??

  it "will create a new payperiod to satisfy a find_payperiod request" do
    date = Date.today() - 100.years
    payperiod = Payperiod.find_payperiod(date)
    expect(payperiod).not_to eq(nil)
    expect(payperiod.start_date).to be <= date
    expect(payperiod.end_date).to be >= date
  end

  it "creates the correct payperiod when given a date"
  #testing Payperiod.construct(date)

end

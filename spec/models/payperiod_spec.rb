require 'spec_helper'
require 'factory_girl_rails'


describe Payperiod do
  it "has a valid factory" do
    expect(FactoryGirl.build(:payperiod)).to be_valid
    @payperiod = FactoryGirl.create(:payperiod)
    expect(@payperiod.start_date).to be <= @payperiod.end_date
    #start date
    #end date
  end

  it "will create a new payperiod to satisfy a find_payperiod request" do
    date = Date.today() - 100.years
    payperiod = Payperiod.find_payperiod(date)
    expect(payperiod).not_to eq(nil)
    expect(payperiod.start_date).to be <= date
    expect(payperiod.end_date).to be >= date
  end

  it "creates the correct payperiod when given a date" do
     date1 = Date.parse("2015-08-05") #Date in first half
     date2 = Date.parse("2015-08-17")  #Date in second half

     payperiod1 = Payperiod.construct(date1)
     expect(payperiod1.start_date).to eq(Date.parse("2015-08-01"))
     expect(payperiod1.end_date).to eq(Date.parse("2015-08-15"))

     payperiod2 = Payperiod.construct(date2)
     expect(payperiod2.start_date).to eq(Date.parse("2015-08-16"))
     expect(payperiod2.end_date).to eq(Date.parse("2015-08-31"))
  end

  #print
  #file_print
end

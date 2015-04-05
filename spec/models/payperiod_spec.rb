require 'spec_helper'
require 'factory_girl_rails'


describe Payperiod do
  it "has a valid factory" do
    expect(FactoryGirl.build(:payperiod)).to be_valid
  end

  it "find_payperiod will create a brand new payperiod to satisfy the request" do
     expect(Payperiod.find_payperiod(Date.today() - 100.years)).not_to eq(nil)
  end

end

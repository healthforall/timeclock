require 'spec_helper'
require 'factory_girl_rails'


describe Payperiod do
  it "has a valid factory" do
    FactoryGirl.build(:payperiod).should be_valid
  end
end

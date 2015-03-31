require 'spec_helper'
require 'factory_girl_rails'


describe Employee do
  it "has a valid factory" do
    FactoryGirl.build(:employee).should be_valid
  end
end

require 'spec_helper'
require 'factory_girl_rails'


describe Employee do
  it "has a valid factory" do
    @employee = FactoryGirl.build(:employee)
    @employee.should be_valid
    expect(@employee.name).to  be_a_kind_of(String)
    expect(@employee.email).to be_a_kind_of(String)
    expect(@employee.uid).to   be_a_kind_of(String)
    expect(@employee.timesheets).not_to be_empty
  end

  it "is invalid without a name" do
    FactoryGirl.build(:employee, name: nil).should_not be_valid
  end

  it "is invalid without an email" do
    FactoryGirl.build(:employee, email: nil).should_not be_valid
  end



  #check clock in function

end

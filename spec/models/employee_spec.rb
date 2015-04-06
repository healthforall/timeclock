require 'spec_helper'
require 'factory_girl_rails'


describe Employee do
  it "has a valid factory" do
    @employee = FactoryGirl.create(:employee)
    expect(@employee).to be_valid
    expect(@employee.name).to  be_a_kind_of(String)
    expect(@employee.email).to be_a_kind_of(String)
    expect(@employee.uid).to   be_a_kind_of(String)
    expect(@employee.timesheets).not_to be_empty
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:employee, name: nil)).not_to be_valid
  end

  it "is invalid without an email" do
    expect(FactoryGirl.build(:employee, email: nil)).not_to be_valid
  end

  it "assigns the google uid to employee the first time they log in"
  # checking Employee.create_on_first_log_in(auth)
  # how to set up a dummy auth?

  it "creates an inandout when clocking in"
  # checking clock_in(bool clockin)
  # check true and false paths

end

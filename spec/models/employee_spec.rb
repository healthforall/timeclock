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

  it "creates an inandout when clocking in" do
    @employee = FactoryGirl.create(:employee)
    @employee.clock_in(true)
    #expect(@employee.timesheets.current[0].days.current[0].in_and_outs[0]).to_not be_nil

    inandout = @employee.timesheets.current[0].days.current[0].in_and_outs.find_dangling_in[0]
    expect(inandout).to_not be nil
  end
  # checking clock_in(bool clockin)

  it "adds an out_time to the correct inandout when clocking out"
  # check true and false paths
      #false path is a clock out


end

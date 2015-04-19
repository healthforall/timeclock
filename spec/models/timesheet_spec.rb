require 'spec_helper'
require 'factory_girl_rails'
require 'byebug'

describe Timesheet do
  it "has a valid factory" do
    expect(FactoryGirl.create(:timesheet)).to be_valid
    timesheet = FactoryGirl.create(:timesheet)
    expect(timesheet.payperiod).to_not eq(nil)
  end

  it "every day of the payperiod is in the timesheet" do
    @timesheet = FactoryGirl.create(:timesheet)
    @payperiod = @timesheet.payperiod
    start_date = @payperiod.start_date
    end_date   = @payperiod.end_date
    (start_date.to_date..(end_date+ 1.day)).each do |day|
      expect(@timesheet.days.where("day = :day" , day: day).length).to eq(1)
    end

  end
  it "calculates the total hours" do
    @timesheet = FactoryGirl.create(:timesheet)
    daycount = 0
    @timesheet.days.each do |day|
      daycount += 1
      day.in_and_outs << InAndOut.create( :in => DateTime.parse(day.day.to_s) , :out =>DateTime.parse(day.day.to_s) + 1.hours + 30.minutes)
    end

    expect(@timesheet.totalHours).to eq(daycount + daycount/2)
  end

  it "checks if there is a lingering check in" do
    @timesheet = FactoryGirl.create(:timesheet)
    @timesheet.days[0].in_and_outs << InAndOut.create( :in => DateTime.now() )
    expect(@timesheet.clockin?).to eq(true)
    @timesheet.days[0].in_and_outs[0].out= DateTime.now() + 5.hours
    expect(@timesheet.clockin?).to eq(false)
  end

end

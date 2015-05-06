require 'spec_helper'
require 'factory_girl_rails'
require 'byebug'

describe Timesheet do
  it "has a valid factory" do
    expect(FactoryGirl.create(:timesheet)).to be_valid
    timesheet = FactoryGirl.create(:timesheet)
    expect(timesheet.payperiod).to_not eq(nil)
  end

  it "contains every day of the payperiod" do
    @timesheet = FactoryGirl.create(:timesheet)
    @payperiod = @timesheet.payperiod
    start_date = @payperiod.start_date
    end_date   = @payperiod.end_date
    (start_date.to_date..(end_date.to_date)).each do |day|
      expect(@timesheet.days.where("day = :day" , day: day).length).to eq(1)
    end
  end

  it "calculates the total hours" do
    @timesheet = FactoryGirl.create(:timesheet)
    daycount = 0.0
    @timesheet.days.each do |day|
      daycount += 1
      day.in_and_outs << InAndOut.create( :in_time => DateTime.parse(day.day.to_s) , :out_time =>DateTime.parse(day.day.to_s) + 1.hours + 30.minutes)
    end

    expect(@timesheet.totalHours).to eq(daycount + daycount/2)
  end

end

require 'spec_helper'
require 'factory_girl_rails'

RSpec.describe Vacation, type: :model do

    before do
        @vacation = FactoryGirl.create(:vacation, :name =>'Sick Leave', :hour=>8)   
    end	
  it "has a valid vacation request" do 
    @vacation=FactoryGirl.create(:vacation)
    expect(@vacation).to be_valid
    expect(@vacation.name).to  be_a_kind_of(String)
    expect(@vacation.hours).to be_a_kind_of(String)
    expect(@vacation.type).to  be_a_kind_of(String)
  end
end

require 'rspec'
require 'spec_helper'
require 'rspec-rails'

describe TimesheetsController, type: :controller do
  # context "if logged in as administrator" do
  #   # Green
  #   before do
  #       @admin = FactoryGirl.create(:employee, :name =>'Employee', :email => "employee20156@gmail.com", :admin=>true)
  #       session[:user_uid] = @admin.uid    
  #       expect(@admin.admin).to eq(true)
  #   end
  #   # describe "Approve time sheet" do
  #   #   if "check "
  #   # end
  # end

  context "if logged in as regular employee" do
    before(:each) do
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.perform_deliveries = true
      ActionMailer::Base.deliveries = []
    end
    
    after(:each) do
      ActionMailer::Base.deliveries.clear
    end


    describe "show one's time sheet" do
      it "finds the correct employee" do
        @employee = double("Employee")
        allow(Employee).to receive(:find_by_id).and_return(@employee)
       
      end
      it "finds the correct payperiod" do
        payperiod = double("Payperiod")
        allow(Payperiod).to receive(:all_cache).and_return(payperiod)        
      end

      it "finds the correct timesheet" do
        timesheet = double("Timesheet")
        allow(Timesheet).to receive(:find_by_id).and_return(timesheet)        
      end
      
      it "shows the view for that timesheet" do
        expect(response).to have_http_status(200)
      end     
    end


    describe "send an email" do
      it "send an email" do
        @employee = FactoryGirl.create(:employee, :name =>'Employee', :email => "employee20156@gmail.com")
        AdminMailer.admin_email( @employee ).deliver_now
        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end

      # it "" do
      # end
      
      # it "sends email sucessfully" do
      #   expect(response).to redirect_to "/employees/:employee.id/timesheets/1/current"
      # end
    end   
    
  end

  # describe "current" do
  #   it "finds the correct employee"
  #   it "finds the current timesheet"
  #   it "shows the view for the current timesheet" #????
  # end

  # describe "update" do

  # end

  # describe "select" do

  # end

  # describe "massExport" do

  # end

end
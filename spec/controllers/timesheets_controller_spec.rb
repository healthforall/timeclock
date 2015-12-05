require 'rspec'
require 'spec_helper'
require 'rspec-rails'

describe TimesheetsController, type: :controller do
  context "if logged in as administrator" do
    # Green
    before do
        @admin    = FactoryGirl.create(:employee, :name =>'Admin', :email => "employee20156@gmail.com", :admin=>true)
        @employee = FactoryGirl.create(:employee, :name =>'Employee', :email => "employee20157@gmail.com")
        session[:user_uid] = @admin.uid    
        expect(@admin.admin).to eq(true)
    end
    describe "Approve time sheet" do
      it "shows a employee timesheet" do
        get :show,:employee_id=> @employee.id, :timesheet_id=> 1 
        expect(response).to have_http_status(200)
      end 
    end
  end

  context "if logged in as regular employee" do
    before(:each) do
      @employee = FactoryGirl.create(:employee, :name =>'User', :email => "employee20156@gmail.com")
      @vacation = FactoryGirl.create(:vacation, :name=>'Sick Leave',:date=>'20151204', :type=>'1', :hour=>8)
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


    describe "send an email", type: :mailer do
      it "has right parameters from the view" do
        expect(@employee.name).not_to eq(nil)
        expect(@vacation.hour).not_to eq(nil)
        expect(@vacation.type).not_to eq(nil)
        expect(@vacation.date).not_to eq(nil)
      end

      let(:mail) { AdminMailer.admin_email_test(@employee.name, @vacation.type, @vacation.date, @vacation.hour ) }
      
      it "send an email" do
        mail.deliver_now
        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end
  
      it "has a right email header" do
        expect(mail.content_type).to start_with('multipart/alternative')
      end
      it "has a right subject" do
        expect(mail.subject).to start_with('Request vacation from')
      end

      it 'renders the receiver email' do
        expect(mail.to).to include("wxp2002@gmail.com")
      end
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
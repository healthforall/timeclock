require 'rspec'
require "rails_helper"
require 'spec_helper'
require 'rspec/expectations'

describe EmployeesController, type: :controller do


  context "if logged in as administrator" do
    # Green
    before do
        @admin = FactoryGirl.create(:employee, :name =>'Employee', :email => "employee20156@gmail.com", :admin=>true)
        session[:user_uid] = @admin.uid    
        expect(@admin.admin).to eq(true)
        
    end
    # Green
    describe "GET #index" do
      it "populates the employees table" do
        get :index
        expect(assigns(:employees)).to eq([@admin])
      end

      # Green
      it "renders the :index view" do           
        get :index, user_uid: @admin.id
        expect(response).to render_template :index
      end
    end
    # Green
    describe "GET #show" do
      it "assigns the requested employee to @employee" do
        @employee = FactoryGirl.create(:employee)
        get :show, id: @employee.id
        expect(assigns(:employee)).to eq(@employee)
      end

      it "renders the #show view" do
        @employee = FactoryGirl.create(:employee)
        get :show, id: @employee.id
        expect(response).to render_template :show
      end
    end

    # describe "GET #new" do
    #   it "creates a new employee"
    # end

    #Green
    describe "POST create" do
      context "with valid attributes" do
        it "creates a new employee" do
          expect{
            post :create, employee: FactoryGirl.attributes_for(:employee)
          }.to change(Employee,:count).by(1)
        end

        it "redirects to the new employee" do
          post :create, employee: FactoryGirl.attributes_for(:employee)
          expect(response).to redirect_to employees_path
        end
      end
    #Green
      context "with invalid attributes" do
        it "does not save the new employee" do
          expect{
            post :create, employee: FactoryGirl.attributes_for(:invalid_employee)
          }.to_not change(Employee,:count)
        end

        it "re-renders the new method" do
          post :create, employee: FactoryGirl.attributes_for(:invalid_contact)
          expect(response).to render_template :new
        end
      end
    end
  end

  # context "as regular employee" do
  #   it "won't let you access this. what does it do?"  #TODO - steven, what is it supposed to do?
  # end

  # describe "clockin" do

  # end

  # describe "edit" do

  # end

  # describe "update" do

  # end

  # describe "destroy" do

  # end

  # describe "admin_user" do

  # end
  
end
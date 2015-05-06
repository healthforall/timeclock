class EmployeesController < ApplicationController
  before_filter :logged_in?
  before_action :admin_user,      only: [:edit,:update,:show,:index,:new,:create,:destroy,:edit]

  # POST create
  def create
    @employee = Employee.new(employee_params) ##Invoke user_params methods
    if @employee.save
      flash[:notice] = "#{@employee.name} was successfully added."
      redirect_to employees_path
    else
      render 'new'
    end
  end

  def clockin
    clockin = params[:clockingin]
    @employee = Employee.find_by_uid(session[:user_uid])
    @employee.clock_in(clockin)
    render(:partial => 'clockinout') if request.xhr?
  end

  # GET #index
  def index
    @employees = Employee.all
    @payperiods = Payperiod.all_cache
  end

  # GET #show
  def show
    id = params[:id]
    @employee = Employee.find(id)

    if (@employee.id == @current_user.id || @current_user.admin)
    else
      redirect_to  "/employees/#{@employee.id}/timesheets/1/current"
    end
  end

  # GET #new
  def new
    @employee = Employee.new
    #AdminMailer.admin_email(@current_user).deliver_now
  end

  # GET #edit
  def edit
      @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find params[:id]
    if @employee.update_attributes(employee_params)
      flash[:notice] = "#{@employee.name} was successfully updated."
      redirect_to employee_timesheet_current_path(@employee , timesheet_id: 1)
    else
      render 'edit'
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    if @employee.uid != @current_user.uid
      flash[:notice] = "Employee '#{@employee.name}' was deleted."
      @employee.destroy
    else
      flash[:notice] = "You tried to delete yourself."
    end
    redirect_to employees_path
  end

  private

  ## Strong Parameters
  def employee_params
    params.require(:employee).permit(:name ,:email)
  end

  def admin_user
    redirect_to  "/employees/#{@current_user.id}/timesheets/1/current" unless @current_user.admin?
  end

  def logged_in?
    redirect_to '/login' if @current_user.nil?
  end
end

class EmployeesController < ApplicationController


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

  def index
    if @current_user.admin
      @employees = Employee.all
    else
      flash[:notice] = "You are not an administrator!"
      redirect_to "/employees/#{@current_user.id}/timesheets/1/current"
    end
  end

  def show
    id = params[:id]
    @employee = Employee.find(id)
    if (@employee.id == @current_user.id || @current_user.admin)
    else
      flash[:notice] = "You do not have permission to view this page"
      redirect_to  "/employees/#{@employee.id}/timesheets/1/current"
    end
  end

  def new
    if @current_user.admin
      @employee = Employee.new
    else
      flash[:notice] = "You may not create a new employee!!!"
      redirect_to  "/employees/#{@current_user.id}/timesheets/1/current"
    end
  end

  def edit
    if @current_user.admin == true
      @employee = Employee.find(params[:id])
    else
      flash[:notice] = "You are not an admin!"
      redirect_to  "/employees/#{@current_user.id}/timesheets/1/current"
    end
  end

  def update
    @employee = Employee.find params[:id]
    if @employee.update_attributes(employee_params)
      flash[:notice] = "#{@employee.name} was successfully updated."
      redirect_to employee_path(@employee)
    else
      render 'edit'
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    if @current_user.admin && @employee.uid != @current_user.uid
      flash[:notice] = "Employee '#{@employee.name}' was deleted."
      @employee.destroy
    else
      flash[:notice] = "You are not an administrator or you tried to delete yourself."
    end
    redirect_to employees_path
  end

  private

  ## Strong Parameters
  def employee_params
    params.require(:employee).permit(:name ,:email)
  end
end

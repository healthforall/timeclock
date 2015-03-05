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

  def index
    @employees = Employee.all
  end

  def show
    id = params[:id]
    @employee = Employee.find(id)
    #Render app/views/movies/show.html.haml by def
  end

  def new
    @employee = Employee.new
    #Will render 'new' template
  end

  def edit
    @employee = Employee.find(params[:id])
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
    @employee.destroy
    flash[:notice] = "Employee '#{@employee.name}' was deleted"
    redirect_to employees_path
  end

  private

  ## Strong Parameters
  def employee_params
    params.require(:employee).permit(:name , :salary)
  end
end

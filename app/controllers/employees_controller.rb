class EmployeesController < ApplicationController

  def create
    Employee.create(employee_params) ##Invoke user_params methods
  end

  def index
    @employees = Employee.all
  end

  def show
    id = params[:id]
  end

  private

  ## Strong Parameters
  def employee_params
    params.require(:employee).permit(:name , :salary)
  end
end

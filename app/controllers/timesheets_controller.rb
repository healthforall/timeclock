class TimesheetsController < ApplicationController
  def show
    @employee  = Employee.find_by_id(params[:employee_id])
    @timesheet = Timesheet.find_by_id(params[:id])
  end

  def current
    @employee  = Employee.find_by_id(params[:employee_id])
    current_date = Date.today()
    @timesheet = @employee.timesheets.current[0] || @employee.timesheets.create!()
  end
end

class TimesheetsController < ApplicationController
  def show
    @current = true;
    @employee  = Employee.find_by_id(params[:employee_id])
    @timesheet = @employee.timesheets.current[0]
    if(!@timesheet)
      @timesheet = @employee.timesheets.create!()
    end
    respond_to do |format|
      format.html
      format.xls
    end
  end

  def current
    @employee  = Employee.find_by_id(params[:employee_id])
    @timesheet = @employee.timesheets.current[0]
    if(!@timesheet)
      @timesheet = @employee.timesheets.create!()
    end
    respond_to do |format|
      format.html { redirect_to "/employees/#{@employee.id}/timesheets/#{@timesheet.id}?format=html"}
      format.xls { redirect_to "/employees/#{@employee.id}/timesheets/#{@timesheet.id}" + ".xls?format=xls" }
    end
  end

  def update
    render(:partial => 'editresponse') if request.xhr?
    print params
  end

end


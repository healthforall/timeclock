require 'json'

class TimesheetsController < ApplicationController
  def show
    @current = true;
    @employee  = Employee.find_by_id(params[:employee_id])
    @payperiods = Payperiod.all
    if(params[:id])
      @timesheet = Timesheet.find_by_id(params[:id])
    end
    if(params[:timesheet_id])
      @timesheet = Timesheet.find_by_id(params[:timesheet_id])
    end
    if(!@timesheet)
      @timesheet = @employee.timesheets.create!()
    end
    debugger

    payperiod = @timesheet.payperiod
    @start_date = payperiod.start_date
    @end_date   = payperiod.end_date
    halves = @timesheet.halves
    @first_week  = halves[0]
    @second_week = halves[1]

    @name = @employee.name
    @uid  = @employee.uid

    @total_hours = @timesheet.totalHours

    respond_to do |format|
      format.html
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"timesheet.xls\"" }
    end
  end

  def current
    @employee  = Employee.find_by_id(params[:employee_id])
    @timesheet = @employee.timesheets.current[0]
    if(!@timesheet)
      @timesheet = @employee.timesheets.create!()
    end
    respond_to do |format|
      format.html { redirect_to  "/employees/#{@employee.id}/timesheets/#{@timesheet.id}?format=html"}
      format.xls  { redirect_to  "/employees/#{@employee.id}/timesheets/#{@timesheet.id}" + ".xls?format=xls" }
    end
  end

  def update
    hash = ActiveSupport::JSON.decode(request.body.read) #WTF I don't know why I had to resort to this

    #print params
    #This currently takes the timesheet at face value
    #print params[:days]
    @timesheet = Timesheet.all()[0]
    #print JSON.parse()
    render json: @timesheet
    #end
  end

  def select
    @employee = Employee.find_by_id(params[:eid])
    payperiod = Payperiod.find_by_id(params[:pid])
    debugger
    @timesheet = @employee.timesheets.where("payperiod_id = ?", payperiod)[0]
    if(!@timesheet)
      @timesheet = @employee.timesheets.create!(payperiod: payperiod)
    end
    respond_to do |format|
      format.html { redirect_to "/employees/#{@employee.id}/timesheets/#{@timesheet.id}?format=html"}
      format.xls  { redirect_to "/employees/#{@employee.id}/timesheets/#{@timesheet.id}" + ".xls?format=xls" }
    end
  end

end


require 'json'
require 'zip'

class TimesheetsController < ApplicationController
  def show
    @current = false
    @employee  = Employee.find_by_id(params[:employee_id])
    @payperiods = Payperiod.all_cache
    @timesheet = Timesheet.find_by_id(params[:timesheet_id])
    @payperiod = @timesheet.payperiod
    if( Payperiod.find_payperiod(Date.today()) == @payperiod )
      @current = true
    end
    @start_date = @payperiod.start_date
    @end_date   = @payperiod.end_date
    halves = @timesheet.halves
    @first_week  = halves[0]
    @second_week = halves[1]
    @name = @employee.name
    @uid  = @employee.uid
    @total_hours = @timesheet.totalHours
    respond_to do |format|
      format.html
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"timesheet_" + @employee.name + "_" + @payperiod.file_print + ".xls\"" }
    end
  end

  def current
    @employee  = Employee.find_by_id(params[:employee_id])
    @timesheet = @employee.timesheets.current[0]
    if(!@timesheet)
      @timesheet = @employee.timesheets.create!()
    end
    respond_to do |format|
      format.html { redirect_to  employee_timesheet_show_path(@employee, @timesheet) }
      format.xls  { redirect_to  employee_timesheet_show_path(@employee, @timesheet, format: "xls") }
    end
  end

  def update
    @payperiod = Payperiod.find_payperiod(Date.today)
    @employee  = Employee.find_by_uid(session[:user_uid])
    @timesheet = Timesheet.find_by_id(params[:timesheet_id])
    @newtimesheet = ActiveSupport::JSON.decode(request.body.read) #This resort is needed
    @newtimesheet = Timesheet.verifyAndCreate(@newtimesheet , @employee , @payperiod)
    if( @timesheet)

      @timesheet.days = @newtimesheet.days
      @timesheet.save!
      render :partial => 'goodedit'
    else
      render(:partial => 'badedit')
    end
  end

  def select
    @employee = Employee.find_by_id(params[:eid])
    payperiod = Payperiod.find_by_id(params[:pid])
    @timesheet = @employee.timesheets.where("payperiod_id = ?", payperiod)[0]
    if(!@timesheet)
      @timesheet = @employee.timesheets.create!(payperiod: payperiod)
    end
    respond_to do |format|
      format.html { redirect_to  employee_timesheet_show_path(@employee, @timesheet) }
      format.xls  { redirect_to  employee_timesheet_show_path(@employee, @timesheet, format: "xls") }
    end
  end

  def massExport
    employees = Employee.all
    payperiod = Payperiod.find_by_id(params[:pid])
    zip_name = "timesheetsa_" + payperiod.file_print + ".zip"
    File.delete("./tmp/#{zip_name}") unless not File.exist?("./tmp/#{zip_name}")
    Zip::File.open("./tmp/#{zip_name}", Zip::File::CREATE) do |zipfile|
      employees.each_with_index do |e , i|
        if e.admin
          next
        end
        @employee = e
        @timesheet = Timesheet.where("payperiod_id = ? AND employee_id = ?", payperiod.id, @employee.id)[0]
        if(!@timesheet)
          @timesheet = @employee.timesheets.create!(payperiod: payperiod)
        end
        data = render_to_string "show.xls"
        filePath = "timesheet_" + @employee.name + "_" + payperiod.file_print + ".xls"
        #tf = Tempfile.new([filePath , ".xls"])
        tf = File.open("#{Rails.root}/tmp/myfile_#{filePath}",'w')
        tf << data
        puts filePath
        puts tf.path
        #zf.put_next_entry(filePath)
        #zf.print IO.read(tf.pat
        print filePath
        zipfile.add(filePath , tf.path) if filePath.present?
        tf.close
      end
    end
    #zip = Tempfile.new(zip_name)
    #Zip::OutputStream.open(zip) do |zf|
    #  employees.each do |e|
    #    if e.admin
    #      next
    #    end
    #    @employee = e
    #    @timesheet = Timesheet.where("payperiod_id = ? AND employee_id = ?", payperiod.id, @employee.id)[0]
    #    if(!@timesheet)
    #      @timesheet = @employee.timesheets.create!(payperiod: payperiod)
    #    end
    #    data = render_to_string "show.xls"
    #    filePath = "timesheet_" + @employee.name + "_" + payperiod.file_print + ".xls"
    #    tf = Tempfile.new(filePath)
    #    tf << data
    #    tf.close
    #    zf.put_next_entry(filePath)
    #    zf.print IO.read(tf.path)
    #  end
    #end
    #zip_data = File.read(zip.path)
    #send_data zip_data, :type => "application/zip", :filename => zip_name
    #zip.close
    #File.delete("#{Rails.root}/tmp/#{zip_name}"
    send_file "./tmp/#{zip_name}", :type => 'application/zip', :filename => "#{zip_name}"
    #File.delete("./tmp/#{zip_name}")
  end

end


#def get_stream(contractors)
#  begin
##    Zip::File.open("#{Rails.root}/tmp/zipfile_name.zip", Zip::File::CREATE) do |zipfile|
 #     contractors.each_with_index do |filename, index|
  #      zipfile.add(filename.try(:cv_file_name), filename.try(:cv).try(:path)) if filename.present?
   #   end
   # end

    #send_file "#{Rails.root}/tmp/zipfile_name.zip", :type => 'application/zip', :filename => "Contractor_cvs.zip", :x_sendfile => true
    #File.delete("#{Rails.root}/tmp/zipfile_name.zip")

#  rescue
 # end
#end

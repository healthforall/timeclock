class AdminMailer < ActionMailer::Base
  default from: "healthforallautomessage@gmail.com"

  def admin_email(employee)
      @employee = employee
      mail(to: @employee.email, subject: 'Admin Email')
  end
end
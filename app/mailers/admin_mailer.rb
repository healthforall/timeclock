class AdminMailer < ActionMailer::Base
  default from: "wxp2002@gmail.com"

  def admin_email(employee)
      @employee = employee
      mail(to: "wxp2002@gmail.com", subject: 'Request vacation from '+@employee.name)

  end
end
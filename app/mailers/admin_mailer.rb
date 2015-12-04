class AdminMailer < ActionMailer::Base
  default from: "wxp2002@gmail.com"

  def admin_email(employee,date)
      @employee = employee
      @date = date
      mail(to: "wxp2002@gmail.com", subject: 'Request vacation from '+@date)

  end
end
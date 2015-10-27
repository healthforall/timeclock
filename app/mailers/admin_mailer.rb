class AdminMailer < ActionMailer::Base
  default from: "wxp2002@gmail.com"

  def admin_email

      mail(to: "wxp2002@tamu.edu", subject: 'Admin Email')

  end
end
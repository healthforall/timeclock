class AdminMailer < ActionMailer::Base
  default from: "wxp2002@gmail.com"

  def admin_email(name)
      @name = name
      mail(to: "wxp2002@gmail.com", subject: 'Request vacation from '+@name)

  end
end
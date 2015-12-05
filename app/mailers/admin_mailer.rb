class AdminMailer < ActionMailer::Base
  default from: ENV['gmail_username']

  def admin_email(name,vacation_type,date,hours)
      @name = name
      @vacation_type = vacation_type
      @date = date
      @hours = hours
      mail(to: "wxp2002@gmail.com", subject: 'Request vacation from '+@name)

  end
end

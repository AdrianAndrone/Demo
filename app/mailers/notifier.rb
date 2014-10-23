class Notifier < ActionMailer::Base
  default from: "actionperform@gmail.com"


  def support_notification(sender)
    @sender = sender
    mail(:to => "actionperform@gmail.com",
         :from => sender.email,
         :subject => "New #{sender.support_type}")
    end



end

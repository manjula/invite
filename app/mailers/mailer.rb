class Mailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer.invitation.subject
  #
def invite_friend(invitation, signup_url)
   @invitation = invitation
   mail(:to => invitation.recipient_email,
         :subject => "Welcome to My Awesome Site",
		 :body => signup_url)
  invitation.update_attribute(:sent_at, Time.now)
end


end

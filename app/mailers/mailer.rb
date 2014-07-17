class Mailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer.invitation.subject
  #
def invite_friend(invitation,user, signup_url)
   @invitation = invitation
   @url = signup_url
   @user = user.name
   mail(:to => invitation.recipient_email,
        :from => user.email,
         :subject => "Please join me") do |format|
		 format.text
		end
		# :body => signup_url)
    invitation.update_attribute(:sent_at, Time.now)
end


end

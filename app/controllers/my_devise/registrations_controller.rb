class MyDevise::RegistrationsController < Devise::RegistrationsController

def new
  #super
  @user = User.new(:invitation_token => params[:invitation_token])
  @user.email = @user.invitation.recipient_email if @user.invitation
end

   def create
      super
	  if resource.save
		 if !resource.invitation_id.blank?
		    @invite = Invitation.find(resource.invitation_id) 
			@invite.update_attribute(:accepted, true)
		 end
   end
   end

end

class UsersController < ApplicationController
before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
	@invitees = User.where(email: @user.sent_invitations.accepted.map(&:recipient_email))
	if !@user.invitation_id.blank?
	    @invitation = Invitation.find(@user.invitation_id)
		@follows = User.find(@invitation.sender_id)
	end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end
    
  def destroy
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end
end


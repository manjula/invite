class InvitationsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_invitation, only: [:show, :edit, :update, :destroy]

  # GET /invitations
  # GET /invitations.json
  def index
    @invitations = Invitation.all
  end

  # GET /invitations/1
  # GET /invitations/1.json
  def show
  end

  # GET /invitations/new
  def new
    @invitation = Invitation.new
  end

  # GET /invitations/1/edit
  def edit
  end

  # POST /invitations
  # POST /invitations.json
  def create
  @invitation = Invitation.new(invitation_params)
     @invitation.sender = current_user
	 path = request.host_with_port
  if @invitation.save
    if user_signed_in?
      Mailer.invite_friend(@invitation,current_user, path+new_user_registration_path(:invitation_token => @invitation.token)).deliver
      flash[:notice] = "Thank you, invitation sent."
      redirect_to users_url
    else
      flash[:notice] = "Thank you, we will notify when we are ready."
      redirect_to root_url
    end
  else
    render :action => 'new'
  end
  end

  # PATCH/PUT /invitations/1
  # PATCH/PUT /invitations/1.json
  def update
    respond_to do |format|
      if @invitation.update(invitation_params)
        format.html { redirect_to @invitation, notice: 'Invitation was successfully updated.' }
        format.json { render :show, status: :ok, location: @invitation }
      else
        format.html { render :edit }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invitations/1
  # DELETE /invitations/1.json
  def destroy
    @invitation.destroy
    respond_to do |format|
      format.html { redirect_to invitations_url, notice: 'Invitation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invitation
      @invitation = Invitation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invitation_params
      params.require(:invitation).permit(:sender_id, :recipient_email, :token, :sent_at, :new)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @invitation = Invitation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:invitation).permit(:recipient_email)
    end
end

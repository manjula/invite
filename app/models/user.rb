class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
		 

#validates_uniqueness_of :invitation_id

has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
belongs_to :invitation



def invitation_token
  invitation.token if invitation
end

def invitation_token=(token)
  self.invitation = Invitation.find_by_token(token)
end

 
		 
end

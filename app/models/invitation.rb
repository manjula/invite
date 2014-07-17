class Invitation < ActiveRecord::Base

belongs_to :sender, :class_name => 'User'
has_one :recipient, :class_name => 'User'

validates_presence_of :recipient_email
validate :recipient_is_not_registered


before_create :generate_token

scope :accepted, -> {where(accepted: true)}

private

def recipient_is_not_registered
  errors.add(:base, 'Email id is already registered') if User.find_by_email(recipient_email)
end



def generate_token
  self.token = SecureRandom.urlsafe_base64(5) #Digest::MD5.hexdigest([Time.now, rand].join).to_s(36)
end



end

class User < ActiveRecord::Base
  has_many :listings
  has_many :bookings
  has_many :booking_requests

  def self.authenticate(email:, password:)
    existing_user = User.find_by(email: email)
    return nil unless existing_user
    return nil unless BCrypt::Password.new(existing_user.password) == password
    { user_id: existing_user.id, user_name: existing_user.name }
    
  end

end

class User < ActiveRecord::Base
  has_many :listings
  has_many :bookings

  def self.authenticate(email:, password:)
    existing_user = User.find_by(email: email)

    if existing_user && password == existing_user.password
      return { user_id: existing_user.id, user_name: existing_user.name }
    else
      return nil
    end
  end

end

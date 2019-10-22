class User < ActiveRecord::Base
  has_many :listings
  has_many :bookings


 def self.authenticate(email:, password:)
   existing_user = User.find_by(email: email)
   p existing_user.id
   p existing_user.name
   if password == existing_user.password
    return { user_id: existing_user.id, user_name: existing_user.name }
   else fail "Incorrect Password"
 end
end

end

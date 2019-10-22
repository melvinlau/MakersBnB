class User < ActiveRecord::Base
  has_many :listings
  has_many :bookings
  has_secure_password

 #  attr_reader :id, :name, :password, :email
 #
 # def initialize(id: , name:, email:, password:)
 #   @name = name
 #   @password = password
 #   @email = email
 #   @id = id
 # end

 def self.authenticate(email:, password:)
   existing_user = User.find_by(email: email)
   p existing_user
   p "Existing user ID #{existing_user.id}"

   p existing_user.password
   p password
   return existing_user.id.to_s if password == existing_user.password
 end

end

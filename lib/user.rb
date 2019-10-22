class User < ActiveRecord::Base
  has_many :listings
  has_many :bookings
  
  attr_reader :id, :name, :password, :email

 def initialize(id: , name:, email:, password:)
   @name = name
   @password = password
   @email = email
   @id = id
 end
end

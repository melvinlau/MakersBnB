require 'user'
require 'listing'
require 'bcrypt'
require_relative 'database_helpers'

describe Listing do

  # Create sample listing data
  let(:name) { 'Swanky apartment'}
  let(:description) { 'The bachelor pad on top of The Shard' }
  let(:price) { 1000.00 }
  let(:location) { 'London Bridge' }
  let(:photo_src) { 'blank'}
  let(:available_date) { '2019-10-21' }
  let(:user_id) { 1 }

  # Create a test user account in the database
  let(:user) {
    User.create(
      email: email,
      password: password,
      name: name,
      username: username
      )
  }


  # create a Listing (i.e. one property)
  describe '.create' do

    it 'creates a new listing' do

      listing = Listing.create(
        name: name,
        description: description,
        price: price,
        location: location,
        photo_src: photo_src,
        available_date: available_date,
        user_id: user.id
      )

      persisted_data = database(table: 'listings', id: listing.id)

      expect(listing.name).to eq persisted_data[0]['name']
      expect(listing.user_id).to eq persisted_data[0]['user_id']
    end


  end

  # display all listings



end

require 'booking'

describe Booking do 

  describe '#create' do
    it 'creates a new booking' do
      booking = Booking.create(user_name: 'Danielle', request_date: 'Date.new', property_id: '1')

      persisted_data = persisted_data(table: :users, id: booking.id)
  
      expect(booking).to be_a Booking
      expect(booking.id).to eq ('1')
      expect(booking.user_name).to eq 'Danielle'
    end
  end

end
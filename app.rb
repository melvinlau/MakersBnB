require 'sinatra'
require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/activerecord'
require 'bcrypt'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'minimagick'

require './lib/user'
require './lib/listing'
<<<<<<< HEAD
require './lib/booking'
require './lib/uploader'
require './lib/image'

# Configure Carrierwave
CarrierWave.configure do |config|
  config.root = File.dirname(__FILE__) + "/static/media"
end
=======
require './lib/booking_requests'
require './lib/booking'

>>>>>>> b6d33b8609c06e7705d307e277d1c84504a17d5b

class MakersBnB < Sinatra::Base
  set :database_file, 'config/database.yml'
  set :public_folder, File.dirname(__FILE__) + "/static"
  enable :sessions, :method_override
  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash

  # Index Page
  get '/' do
    @user = User.find_by(id: session[:user_id]) || nil
    @feed = Listing.all

    @page = erb(:index)
    erb(:template)
  end

  post '/listing/create' do
<<<<<<< HEAD

    listing = Listing.create(
=======
      Listing.create(
>>>>>>> b6d33b8609c06e7705d307e277d1c84504a17d5b
      name: params[:name],
      description: params[:description],
      price: params[:price],
      location: params[:location],
      available_date: params[:available_date],
      user_id: session[:user_id]
    )

    img = Image.new
    img.image = params[:image]
    img.listing_id = listing.id
    img.save!

    redirect '/'
  end

  get '/listing/new' do
    @page = erb(:add_listing)
    erb(:template)
  end

  get '/listing/:id' do
    @listing = Listing.find_by(id: params[:id])
    @host_user = User.find_by(id: @listing.user_id)
<<<<<<< HEAD
    @image = Image.find_by(id: @listing.id)
=======
    @user = User.find_by(id: session[:user_id])
>>>>>>> b6d33b8609c06e7705d307e277d1c84504a17d5b
    @page = erb(:complete_listing)
    erb(:template)
  end

  delete '/listing/:id' do
    Listing.delete(params[:id])
    redirect '/'
  end

  delete '/booking/:id' do
    Booking.delete(params[:id])
    redirect '/bookings'
  end

  delete '/booking-request/:id' do
    BookingRequest.delete(params[:id])
    redirect '/requests'
  end

  get '/requests' do
    @requests = BookingRequest.get_user_requests(user_id: session[:user_id])
    erb :booking_request_list
  end

  post '/booking-request/new' do
    listing = Listing.find_by(id: params[:listing])
    BookingRequest.create(
      user_id: listing.user_id,
      listing_id: listing.id,
      guest: session[:user_id],
      requested_date: listing.available_date
    )
    redirect '/'
  end

  post '/booking/new' do
    BookingRequest.confirm(id: params[:br_id])
    redirect '/requests'
  end

  # Sign Up
  post '/users/new' do
    if User.find_by(email: params[:email])
      flash[:notice] = 'An account already exists with this email address. Please use another.'
    else
      encrypted_password = BCrypt::Password.create(params[:password])
      user = User.create(
        email: params[:email],
        password: encrypted_password,
        name: params[:name]
      )
      session[:user_id] = user.id
      session[:user_name] = user.name
    end

    redirect '/'
  end

  # Sign In
  post '/users/session' do
    user = User.authenticate(email: params[:email], password: params[:password])

    if user
      session[:user_id] = user[:user_id]
      session[:user_name] = user[:user_name]
    else
      flash[:notice] = 'Please check your email or password.'
    end
    redirect '/'
  end

  # Sign Out
  post '/users/:id/session/destroy' do
    session.clear
    flash[:notice] = "You have successfully signed out."
    redirect '/'
  end

  # Delete a listing
  # duplicate? Is this needed?
  post '/listing/:id/delete' do
    Listing.delete(id: params[:listing_id])
    redirect '/'
  end

  get '/bookings' do
    @bookings = Booking.get_user_bookings(user_id: session[:user_id])
    erb :bookings_list
  end





  run! if app_file == $0

end

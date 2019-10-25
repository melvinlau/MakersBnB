require 'sinatra'
require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/activerecord'
require 'bcrypt'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'mini_magick'

require './lib/user'
require './lib/listing'
require './lib/booking'
require './lib/booking_requests'
require './lib/uploader'
require './lib/bookable_day'
require './lib/available_day'
require './ponymailer.rb'



# Configure Carrierwave
CarrierWave.configure do |config|
  config.root = File.dirname(__FILE__) + "/static/media"
end

class MakersBnB < Sinatra::Base
  set :database_file, 'config/database.yml'
  set :public_folder, File.dirname(__FILE__) + "/static"
  enable :sessions, :method_override
  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash

  # Index Page
  get '/' do
    @feed = Listing.all
    @page = erb(:index)
    @user = User.find_by(id: session[:user_id])
    @sidebar = erb(:sidebar)
    erb(:template)
  end

  # ========= LISTING

  post '/listing/create' do
    p "---------------"
    p params[:image]
    p "---------------"
    listing = Listing.create(
      name: params[:name],
      description: params[:description],
      price: params[:price],
      location: params[:location],
      user_id: session[:user_id],
      photo_src: params[:image]
    )
    p "---------------"
    p listing
    p "---------------"
    AvailableDay.new_listing_days(listing_id: listing.id, days_hash: params[:date])
    redirect '/'
  end

  get '/listing/new' do
    BookableDay.generate(today: DateTime.now.midnight)
    @days = BookableDay.all
    @page = erb(:add_listing)
    @user = User.find_by(id: session[:user_id])
    @sidebar = erb(:sidebar)
    erb(:template)
  end

  get '/listing/:id' do
    @user = User.find_by(id: session[:user_id])
    @listing = Listing.find_by(id: params[:id])
    @host_user = User.find_by(id: @listing.user_id)
    @page = erb(:complete_listing)
    p "-------------------"
    p session[:user_id]
    p "-------------------"
    @sidebar = erb(:sidebar)
    erb(:template)
  end

  delete '/listing/:id' do
    Listing.delete(params[:id])
    redirect '/'
  end

  # ========= BOOKING

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
    @page = erb(:booking_request_list)
    @user = User.find_by(id: session[:user_id])
    @sidebar = erb(:sidebar)
    erb(:template)
  end

  post '/booking-request/new' do
    listing = Listing.find_by(id: params[:listing])
    BookingRequest.create(
      user_id: listing.user_id,
      listing_id: listing.id,
      guest: session[:user_id],
      bookable_day_id: params[:date]
    )
    redirect '/'
  end

  post '/booking/new' do
    BookingRequest.confirm(id: params[:br_id])
    redirect '/booking/confirm'
  end

  get '/booking/confirm' do
    options = { :via_options           => {
      :address              => "smtp.gmail.com",
      :port                 => 587,
      :user_name            => 'makersbnb2019@gmail.com',
      :password             => 'testtickles2019',
      :authentication       => 'plain',
      :enable_starttls_auto => true,
  },
  :via                  => :smtp }
  p ENV['EMAIL']

    mailer = Mailer.new(options)

    details = { to: 'makersbnb2019@gmail.com',
                from: 'makersbnb2019@gmail.com',
                subject: 'MakersBnB booking confirmed!',
                template_path: 'views/awesome_email.html.erb' }
    
    mailer.awesome_email(details)
    redirect '/requests'
  end

  # ========= USER

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

  post '/listing/:id/delete' do
    Listing.delete(id: params[:listing_id])
    redirect '/'
  end

  get '/bookings' do
    @bookings = Booking.get_user_bookings(user_id: session[:user_id])
    @page = erb(:bookings_list)
    @user = User.find_by(id: session[:user_id])
    @sidebar = erb(:sidebar)
    erb(:template)
  end

  run! if app_file == $0

end

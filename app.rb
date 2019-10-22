require 'sinatra'
require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/activerecord'
require 'bcrypt'


require './lib/user'
require './lib/listing'

class MakersBnB < Sinatra::Base
  set :database_file, 'config/database.yml'
  set :public_folder, File.dirname(__FILE__) + "/static"
  enable :sessions, :method_override
  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash

  # Index Page
  get '/' do
    @user = session[:user]
    # @feed = Peep.all
    @page = erb(:index)
    erb(:template)
  end

  post '/create' do
    Listing.create(
      title: params[:title],
      description: params[:description],
      price: params[:price],
      location: params[:location],
      date: params[:date],
      user_id: session[:user].id
    )
    p params
    redirect '/'
  end

  get '/view' do
    @page = erb(:complete_listing)
    erb(:template)
  end

  get '/new-listing' do
    @page = erb(:add_listing)
    erb(:template)
  end

  # Sign Up
  post '/users/new' do
    user = User.create(
      email: params[:email],
      password: params[:password],
      name: params[:name],
      username: params[:username]
    )
    if user == 'Email exists'
      flash[:notice] = 'An account already exists with this email address. Please use another.'
    elsif user == 'Username exists'
      flash[:notice] = 'An account already exists with this username. Please choose another.'
    else
      session[:user] = user
    end
    redirect '/'
  end

  # Sign In
  post '/users/session' do
    user = User.authenticate(
      email: params[:email],
      password: params[:password]
    )
    if user
      session[:user] = user
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
  post '/listing/:id/delete' do
    Listing.delete(id: params[:listing_id])
    redirect '/'
  end

  run! if app_file == $0

end

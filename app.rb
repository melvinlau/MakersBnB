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
    @user = User.find_by(id: session[:user_id]) || nil
    @feed = Listing.all
    @page = erb(:index)
    erb(:template)
  end

  post '/listing/create' do
       Listing.create(
      name: params[:name],
      description: params[:description],
      price: params[:price],
      location: params[:location],
      available_date: params[:available_date],
      user_id: session[:user_id]
    )
    redirect '/'
  end

  get '/listing/new' do
    @page = erb(:add_listing)
    erb(:template)
  end

  get '/listing/:id' do
    @listing = Listing.find_by(id: params[:id])
    @host_user = User.find_by(id: @listing.user_id)
    @user = User.find_by(id: session[:user_id])
    @page = erb(:complete_listing)
    erb(:template)
  end

  delete '/listing/:id' do
    Listing.delete(params[:id])
    redirect '/'
  end

  # Sign Up
  post '/users/new' do
    user = User.create(
      email: params[:email],
      password: params[:password],
      name: params[:name]
    )
    session[:user_id] = user.id
    session[:user_name] = user.name
    redirect '/'
  end

  # Sign In
  post '/users/session' do
    user = User.authenticate(email: params[:email], password: params[:password])
    session[:user_id] = user[:user_id]
    session[:user_name] = user[:user_name]
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

require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/activerecord'
require 'bcrypt'

require_relative './lib/user'
require_relative './lib/listing'

class MakersBnB < Sinatra::Base

  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash

  set :database_file, 'config/database.yml'
  set :public_folder, File.dirname(__FILE__) + "/static"

  enable :sessions, :method_override

  run! if app_file == $0

end

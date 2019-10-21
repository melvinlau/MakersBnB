require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/activerecord'
require 'bcrypt'

require_relative './lib/listing'

class MakersBnB < Sinatra::Base

  set :database_file, 'config/database.yml'

  enable :sessions, :method_override
  set :public_folder, File.dirname(__FILE__) + "/static"

  register Sinatra::Flash
  register Sinatra::ActiveRecordExtension


  run! if app_file == $0

end

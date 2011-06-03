require 'sinatra/base'
require 'haml'

require './lib/person.rb'
require './lib/registration.rb'

class Directory < Sinatra::Base

  use Rack::Session::Pool, :expire_after => 60 * 60
  set :session_secret, ENV['session_secret']

  get '/' do
    haml :index
  end

  get '/profile' do
    redirect '/notlogged' if !profile
    haml :profile
  end

  get '/assets/*' do |file|
    send_file File.join('.',request.path)
  end

  not_found do
    haml "Page introuvable"
  end

end

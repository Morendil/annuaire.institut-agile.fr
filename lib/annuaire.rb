require 'sinatra/base'

require './lib/person.rb'
require './lib/registration.rb'

class Annuaire < Sinatra::Base

  use Rack::Session::Pool, :expire_after => 60 * 60
  set :session_secret, ENV['session_secret']

  get '/' do
    haml 'Bienvenue dans l\'annuaire des praticiens Agiles!'
  end

  get '/assets/*' do |file|
    send_file File.join('.',request.path)
  end

  not_found do
    haml "Page introuvable"
  end

end

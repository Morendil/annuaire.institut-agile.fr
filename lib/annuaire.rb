require 'sinatra/base'

class Annuaire < Sinatra::Base
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

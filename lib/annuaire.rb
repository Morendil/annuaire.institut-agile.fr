require 'sinatra/base'

class Annuaire < Sinatra::Base
  get '/' do
    haml 'Bienvenue dans l\'annuaire des praticiens Agiles!'
  end

  get '/login' do
    redirect 'http://linkedin.com'
  end

  get '/status' do
    haml :notlogged
  end

  get '/assets/*' do |file|
    send_file File.join('.',request.path)
  end

  not_found do
    haml "Page introuvable"
  end
  
end

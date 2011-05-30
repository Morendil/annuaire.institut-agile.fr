require 'sinatra/base'

class Annuaire < Sinatra::Base
  get '/' do
    haml 'Bienvenue dans l\'annuaire des praticiens Agiles!'
  end
end

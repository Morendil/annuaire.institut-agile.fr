require 'sinatra/base'

require './lib/person.rb'
require './lib/registration.rb'

class Annuaire < Sinatra::Base
  get '/' do
    haml 'Bienvenue dans l\'annuaire des praticiens Agiles!'
  end

  get '/status' do
    template = profile ? :logged : :notlogged
    who = Person.get(profile.id) if profile
    r = haml template, :layout => false
    r += "\nInscrivez-vous" if profile && !who
    r
  end

  get '/assets/*' do |file|
    send_file File.join('.',request.path)
  end

  not_found do
    haml "Page introuvable"
  end

end

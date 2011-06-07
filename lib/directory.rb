require 'sinatra/base'
require 'haml'
require 'mustache'

require './lib/rendering.rb'
require './lib/person.rb'
require './lib/registration.rb'
require './lib/roadmap.rb'

class Directory < Sinatra::Base

  use Rack::Session::Pool, :expire_after => 60 * 60
  set :session_secret, ENV['session_secret']

  get '/' do
    haml :index
  end

  post '/profile/add' do
    Person.get(profile.id).experiences.create(:practice=>params[:practice])
    redirect '/profile'
  end

  get '/profile' do
    redirect '/notlogged' if !profile || !Person.get(profile.id)
    @experiences = Person.get(profile.id).experiences
    @practices = Roadmap.all
    haml (mustache :profile)
  end

  get '/persons' do
    redirect '/notlogged' if !profile
    @values = Person.all 
    haml (mustache :persons)
  end

  get '/assets/*' do |file|
    send_file File.join('.',request.path)
  end

  not_found do
    haml :notfound
  end

end

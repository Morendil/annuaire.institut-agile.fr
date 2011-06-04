require 'sinatra/base'
require 'haml'
require 'sinatra/mustache'

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

  get '/persons' do
    redirect '/notlogged' if !profile
    @values = Person.all 
    expanded = mustache :persons
    # workaround for a Sinatra bug
    @default_layout = nil
    haml expanded
  end

  get '/assets/*' do |file|
    send_file File.join('.',request.path)
  end

  not_found do
    haml :404
  end

end

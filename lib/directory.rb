require 'sinatra/base'
require 'haml'
require 'sinatra/mustache'

require './lib/person.rb'
require './lib/registration.rb'

class Directory < Sinatra::Base

  use Rack::Session::Pool, :expire_after => 60 * 60
  set :session_secret, ENV['session_secret']

  # Workaround for a bug hindering "template chaining" (see below)
  def render(engine, data, options={}, locals={}, &block)
    super.tap {@default_layout = nil}
  end

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
    haml (mustache :persons)
  end

  get '/assets/*' do |file|
    send_file File.join('.',request.path)
  end

  not_found do
    haml :notfound
  end

end

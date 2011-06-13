require 'sinatra/base'
require 'haml'
require 'mustache'

require './lib/rendering.rb'
require './lib/person.rb'
require './lib/registration.rb'
require './lib/roadmap.rb'
require './lib/helpers.rb'

class Directory < Sinatra::Base

  use Rack::Session::Pool, :expire_after => 60 * 60
  set :session_secret, ENV['session_secret']

  before do
    cache_control :no_cache
  end

  get '/' do
    expires 500, :public, :must_revalidate
    haml :index
  end

  post '/profile/add' do
    current_user.experiences.create(
      :practice=>params[:practice],
      :type=>params[:type])
    redirect '/profile'
  end

  get '/profile/edit/:id' do |id|
    @practices = Roadmap.options
    @instance = current_user.experiences.get(id)
    haml (mustache :experience_edit), :layout => !request.xhr?
  end

  post '/profile/edit/:id' do |id|
    current_user.experiences.get(id).update(
      :practice=>params[:practice],
      :type=>params[:type])
    redirect '/profile'
  end

  post '/profile/delete/:id' do |id|
    current_user.experiences.get(id).destroy
    redirect '/profile'
  end

  get '/profile' do
    redirect '/notlogged' if !profile 
    redirect '/status' if !Person.get(profile.id)
    @experiences = Person.get(profile.id).experiences
    @practices = Roadmap.options
    haml (mustache :profile)
  end

  get '/persons' do
    redirect '/notlogged' if !profile
    @values = Person.all 
    haml (mustache :persons)
  end

  get '/assets/*' do |file|
    expires 500, :public, :must_revalidate
    send_file File.join('.',request.path)
  end

  not_found do
    haml :notfound
  end

end

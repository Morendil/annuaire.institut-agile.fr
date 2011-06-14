require 'sinatra/base'
require 'linkedin'
require 'cgi'

class Directory < Sinatra::Base

  get '/register' do
    haml :register
  end

  post '/register' do
    register(profile).save
    haml :registered
  end

  get '/notlogged' do
    haml :notlogged
  end

  get '/status' do
    template = profile ? :logged : :notlogged
    who = Person.get(profile.id) if profile
    template = :invite if profile && !who
    haml template, :layout => !request.xhr?
  end

  get '/login' do
    session.delete(:profile)
    response.delete_cookie("oauth")
    callback = to(callback(request.referrer || "/"))
    client=LinkedIn::Client.new(ENV['LinkedIn_Key'],ENV['LinkedIn_Secret'])
    result = client.request_token :oauth_callback => callback 
    session[:oauth]=result
    redirect result.authorize_url
  end

  get '/done' do
    where = params[:backto] || "/"
    redirect '/notlogged' if !profile
    redirect to(where)
  end

  def current_user
    Person.get(profile.id)
  end

  def profile
    return @profile = session[:profile] if session[:profile]
    @profile = session[:profile] = retrieve_profile
  end

  def retrieve_profile
    cookie = request.cookies["oauth"]
p "Cookie:",cookie
    tokens = session.delete(:oauth)
p "Auth tokens:",tokens
    return unless cookie || tokens
    begin
      client=LinkedIn::Client.new(ENV['LinkedIn_Key'],ENV['LinkedIn_Secret'])
      connect_client client, cookie, tokens
      return client.profile :public => true
    rescue Exception => e
    end
  end

  def connect_client client, cookie, tokens
    response.delete_cookie("oauth")
    client.authorize_from_access(*cookie.split("&")) if cookie
    cookie = authorize(client,tokens) if tokens
p "Sending back cookie:",cookie
    response.set_cookie(
      "oauth",
      {:domain=>"institut-agile.fr",
       :path=>"/",
       :value=>cookie}) if cookie
  end

  def authorize client, t
p "Authorizing with token:",t,params[:oauth_verifier]
    client.authorize_from_request(t.token,t.secret,params[:oauth_verifier])
  end

  def callback from
    "/done?backto=#{CGI::escape(from)}"
  end

 def register profile
     Person.new(
      :id=>profile.id,
      :first_name=>profile.first_name,
      :last_name=>profile.last_name,
      :since=>Time.now)
  end

end

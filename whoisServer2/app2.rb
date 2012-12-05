require "sinatra"
require "whois"
require "sinatra/reloader"
require "json"

set :public_folder, File.dirname(__FILE__) + '/public'

get '/' do
	erb :index
end

post '/whois' do
	content_type= :json

	w = Whois::Client.new
	@domain = params[:domain]
	result = w.query(@domain)
	@state = "unavailable"
	@state = "available" if result.available?

	{:domain => @domain, :state => @state}.to_json
end




#post '/hi' do
	#w = Whois::Client.new
	#domain= params[:domain]
	#result = w.query(domain)
#if result.available?
	#"Your domain " + domain + " is available!"
#else
	#"Try another domain name."
#end
#end
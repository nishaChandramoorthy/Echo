require 'sinatra'
require 'haml'

set :port, 1237

get '/' do 
  haml :index2
end

get '/view/:page' do
  haml params[:page].to_sym
end

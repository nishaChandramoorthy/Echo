require 'sinatra'
require 'haml'

set :port, 1234

get '/' do 
  haml :index
end

get '/bookshelves' do
  haml :bookshelves
end

get '/activity' do
  haml :activity
end

get '/search' do 
  haml :search
end

get '/suggestions' do
  haml :suggestions
end

get '/reading-list' do
  haml :readingList
end

get '/communities' do
  haml :communities 
end

get '/friends' do
  haml :friends
end

get '/history' do
  haml :history
end



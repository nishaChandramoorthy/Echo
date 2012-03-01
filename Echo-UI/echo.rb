require 'sinatra'
require 'haml'

set :port, 1237

get '/' do 
  haml :index2
end

get '/bookshelves' do
  haml :bookshelves2
end

get '/bookshelf' do
  haml :bookshelf
end

get '/activity' do
  haml :activity
end

get '/search' do 
  haml :search2
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



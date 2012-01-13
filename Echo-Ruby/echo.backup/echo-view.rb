$LOAD_PATH << "/home/sdslabs/EchoInstallations/Echo-Ruby/echo"
$LOAD_PATH << "/home/sdslabs/EchoInstallations/Echo-Ruby/echo/lib"

require 'sinatra'
require 'json'
require 'viewHelper.rb'
require 'home.rb'
require 'result.rb'
require 'book.rb'
require 'recommend.rb'
require 'settings.rb'

ECHO_ROOT= File.join(File.expand_path(File.dirname(__FILE__)), '..') unless defined?(ECHO_ROOT)

#--Configuration ------------
configure do
    set :port, 4568
    set :public, File.dirname(__FILE__) + "/public"
    set :root, File.dirname(__FILE__)
    set :app_file, __FILE__
    set :views, Proc.new {File.join(root, "views")}
    set :show_exceptions, true
    set :dump_errors, true
end

get '/' do  
  HOME.view()
end

get '/category/?query' do

end

get '/search/?' do
  content_type :json
  query = params[:query]                                 
  puts query
  RESULT.getEchoResult(query)
  RESULT.getJSON()
end

get '/download/?' do 
  id = params[:id]
  name = params[:name]
  send_file(SETTINGS.filePath + id, :filename => name)
end

get '/book/?' do
  id = params[:id]
  BOOK.getDetails(id)
  BOOK.getJSON()
end


get '/recommend/?' do
  id = params[:id]
  RECOMMEND.getSimilarBooks(id)
  RECOMMEND.getJSON()
end

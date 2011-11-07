$LOAD_PATH << "/home/nisha/Echo/echo"
$LOAD_PATH << "/home/nisha/Echo/echo/lib"

require 'sinatra'
require 'json'
require 'viewHelper.rb'
require 'home.rb'
require 'result.rb'

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

get '/?' do
  query = params[:search]
  RESULT.view()
end

get '/category/?query' do

end

get '/search/?' do
  query = params[:query]                                 
  puts query
  RESULT.view()
end

get '/noResults' do

end



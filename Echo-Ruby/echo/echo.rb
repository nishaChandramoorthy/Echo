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
require 'category.rb'
require 'category_search.rb'

ECHO_ROOT= File.join(File.expand_path(File.dirname(__FILE__)), '..') unless defined?(ECHO_ROOT)

#--Configuration ------------
configure do
    set :port, 4568
    set :public_folder, File.dirname(__FILE__) + "/public"
    set :root, File.dirname(__FILE__)
    set :app_file, __FILE__
    set :views, Proc.new {File.join(root, "views")}
    set :show_exceptions, true
    set :dump_errors, true
end

get '/' do  
  HOME.view()
end

get '/category/?' do
  content_type :json
  category = params[:query]
  category.downcase!
  CATEGORY.getBookList(category)
  CATEGORY.getJSON()
end

get '/search/category/?' do
  content_type :json
  query = params[:query]
  query.downcase!
  CATEGORY_SEARCH.getCategoryResult(query)
  CATEGORY_SEARCH.getJSON()
end

get '/search/?' do
  content_type :json
  query = params[:query]
  query.downcase!
  puts query
  if query != ""
  RESULT.getEchoResult(query)
  RESULT.getJSON()
  end
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


get '/homepage' do
  content_type :json
  RESULT.getEchoResult("fantasy")
 res= RESULT.getJSON()
 rod = JSON.parse(res)
 rod[0].to_json

    
  


end
get '/about' do
  ab= "Echo is an e-book search and recommendation engine. Fire away specific queries to let echo show you exactly what book you were looking for." 
end

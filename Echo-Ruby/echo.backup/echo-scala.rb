require 'rest_client'
require 'json'
require 'sinatra'

get '/search/?' do
  query = params[:query]
  url="http://192.168.208.158:1237/?query=" + query
  res = RestClient.get(url){ |response, request, result, &block|
                             case response.code
                               when 200
                                 result = JSON.parse(response.body)
                                 result.each{ |bookid| puts bookid }
                               end
  }

end
  


require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'pry'

also_reload 'models/trail' # remember to if development? - once deployed to Heroku
require_relative 'models/trail'


get '/' do
  all_trails = find_all_trails

  erb :index, locals: { all_trails: all_trails }
end

get '/trails/:id' do
  trail = find_one_trail_by_id params["id"]

  erb :show_trail, locals: { one_trail: trail }

end 


get '/trails/new' do 
    
  erb :new_trail
end 

post '/trails' do
  create_trail params["title"], params["image_url"], params["description"], params["rating"], params["difficulty"]

  redirect '/'
end 






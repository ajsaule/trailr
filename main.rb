require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'pry'

also_reload 'models/trail' # remember to if development? - once deployed to Heroku
require_relative 'models/trail'
require_relative 'models/user'

enable :sessions 

get '/' do
  all_trails = find_all_trails

  erb :index, locals: { all_trails: all_trails }
end

get '/trails/new' do 
    
  erb :new_trail
end 

get '/trails/:id' do
  trail = find_one_trail_by_id params["id"]

  erb :show_trail, locals: { trail: trail }
end 

post '/trails' do
  create_trail params["title"], params["image_url"], params["description"], params["rating"], params["difficulty"]

  redirect '/'
end 

delete '/trails' do 
  destroy_trail params["id"]

  redirect "/"
end 

get '/login' do

  erb :login
end

## fix login screen and authentication 
## engineer so that only the user that created certain posts can edit and remove them.. 
## also attach a user ID to a post when it is created, so that we can do a session["id"] check if it is ok to delete the post. 

post '/login' do
  user = find_one_user_by_email( params["email"] )

  if user && BCrypt::Password.new(user["password_digest"]) == params["password"]
    session["user_id"] = user["id"]
    redirect "/"
  else 
   erb :login
  end
end 

def logged_in? 
  if session["user_id"]
    return true
  else
    return false
  end 
end

=begin
get '/logout' do
  Animate a button in for the user to click to confirm a logout
  is this possible without javascript? 
end
=end 

delete '/login' do 
  session["user_id"] = nil 

  redirect "/"
end







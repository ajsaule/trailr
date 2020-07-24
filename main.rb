require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'

also_reload 'models/trail' if development? 
require_relative 'models/trail'
require_relative 'models/user'

enable :sessions 

## =====-- INDEX PAGE/ FIND ALL TRAILS --===== ##
get '/' do
  all_trails = find_all_trails
  all_users = find_all_users

  erb :index, locals: { all_trails: all_trails }
end

## =====-- NEW TRAIL SCREEN --===== ##
get '/trails/new' do 
    
  erb :new_trail
end 

## =====-- EDIT/ UPDATE TRAIL BY ID --===== ##
get '/trails/:id/edit' do
  trail = find_one_trail_by_id params["id"]
  if session["user_id"] == trail["user_id"]
  erb :edit_trail, locals: { trail: trail }
  else 
    ## show a login page 
    "Make an account to edit posts!"
  end
end

patch '/trails/:id' do
  update_trail params["title"], params["image_url"], params["description"], params["rating"], params["difficulty"], params["id"]

  redirect "/trails/#{params["id"]}"
end 

get '/trails/:id' do
  trail = find_one_trail_by_id params["id"]

  erb :show_trail, locals: { trail: trail }
end 

## =====-- CREATE NEW TRAIL IF LOGGED IN --===== ##
post '/trails' do
  if logged_in? 
  create_trail params["title"], params["image_url"], params["description"], params["rating"].to_i, params["difficulty"], session["user_id"]
  else 
    redirect "/signup"
  end 
  
  redirect '/'
end 

delete '/trails' do 
  destroy_trail params["id"]

  redirect "/"
end 

## =====-- SEARCH FOR NEW TRAIL --===== ##
get '/search' do
  "searching..."
end


## =====-- LOGIN/ SIGNUP --===== ##
get '/login' do

  erb :login
end


get '/signup' do 

  erb :sign_up
end 

post '/signup' do
  create_user params["username"], params["email"], params["password"]
  user = find_one_user_by_email params["email"]
  session["user_id"] = user["id"]

  redirect "/"
end 

post '/login' do
  user = find_one_user_by_username( params["username"] )

  if user && BCrypt::Password.new(user["password_digest"]) == params["password"]
    session["user_id"] = user["id"]
    redirect "/"
  else 
   erb :login
  end
end 

## =====-- METHOD TO DEFINE IF LOGGED IN or NOT --===== ##
def logged_in? 
  # or use double negation .. !!session["user_id"]
  if session["user_id"]
    return true
  else
    return false
  end 
end

def current_user 
  find_user_by_id session["user_id"]
end

=begin
get '/logout' do
  Animate a button in for the user to click to confirm a logout
  is this possible without javascript? 
end
=end 

## =====-- LOGOUT --===== ##
delete '/login' do 
  session["user_id"] = nil 

  redirect "/"
end







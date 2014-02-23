require 'rubygems'
require 'sinatra'
require 'sinatra/activerecord'
require 'rest-client'
require 'json'
require 'pry'


require_relative 'lib/db_checker.rb'
# set :database, "sqlite3:///groceryapp.sqlite3"
require './models.rb'


set :port, 9393
enable :sessions

CLIENT_ID = ENV['CLIENT_ID']
CLIENT_SECRET = ENV['CLIENT_SECRET']

get "/" do
  @title = "GetThis2"
  erb :signin, :locals => {:client_id => CLIENT_ID }
end

get '/callback' do
  session_code = request.env['rack.request.query_hash']['code']

  result = RestClient.post('https://github.com/login/oauth/access_token',
                          {:client_id => CLIENT_ID,
                           :client_secret => CLIENT_SECRET,
                           :code => session_code},
                           :accept => :json)

  access_token = JSON.parse(result)['access_token']

  @user_info = RestClient.get("https://api.github.com/user?access_token=#{access_token}")
  @user_info_id = JSON.parse(@user_info)["id"]
  @user_info_email = JSON.parse(@user_info)["email"]

  if User.find_by(email: @user_info_email)
    @user = User.find_by(email: @user_info_email)
    @user.update(user_num: @user_info_id)
  else
    @user = User.find_or_create_by(user_num: @user_info_id, email: @user_info_email)
  end
  session[:user_id] = @user.id
  redirect "user/index"
end


get "/user/index" do
  @title = "Welcome User"
  @user = User.find(session[:user_id])

  erb :"/user/index"
end

get "/user/:id/lists" do
  @title = "Your Lists"
  @user = User.find(session[:user_id])

  erb :lists
end

get "/user/:id/lists/new" do
  @title = "New List"
  @user = User.find(session[:user_id])

  erb :"/user/lists/make_list" 
end

post "/user/:id/lists/new" do
  @title = "New List"
  @user = User.find(session[:user_id])
  @list = @user.lists.create(user_id: @user.id, name: params[:listname], keyword: "store")
  redirect "user/lists/#{@list.id}" 
end

get "/user/lists/:id" do
  @title = "My List"
  @user = User.find(session[:user_id])
  @list = List.find(params[:id])
  @title = "Add items"
  
  erb :"/user/lists/add_items"
end

post "/user/lists/:id" do
  @title = "Add Items"
  @list = List.find(params[:id])
  @item = @list.items.create(list_id: @list.id, name: params[:itemname], quantity: params[:quantity], completed: false)
  redirect "user/lists/#{@list.id}/items"
end

get "/user/lists/:id/items" do
  @title = "My List"
  @list = List.find(params[:id])

  erb :"user/lists/display_list"
end

get "/user/lists/:id/share" do
  @title = "Share My List"
  @list = List.find(params[:id])

  erb :"user/lists/share_list"
end

post "/user/lists/:id/share" do
  @title = "Share My List"
  @list = List.find(params[:id])
  @user = User.find(session[:user_id])

  @user1 = User.find_or_create_by(email: params[:email])
  @list.users << @user1

  redirect "/user/#{@user.id}/lists"
end


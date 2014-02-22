require 'rubygems'
require 'sinatra'
require 'sinatra/activerecord'

require 'rest-client'
require 'json'

require_relative 'lib/db_checker.rb'
set :database, "sqlite3:///groceryapp.sqlite3"
require './models.rb'

CLIENT_ID = ENV['CLIENT_ID']
CLIENT_SECRET = ENV['CLIENT_SECRET']


get "/" do
  @title = "GetThis2"
  erb :index, :locals => {:client_id => CLIENT_ID }
end

get '/callback' do
  # get temporary GitHub code...
  session_code = request.env['rack.request.query_hash']['code']

  # ... and POST it back to GitHub
  result = RestClient.post('https://github.com/login/oauth/access_token',
                          {:client_id => CLIENT_ID,
                           :client_secret => CLIENT_SECRET,
                           :code => session_code},
                           :accept => :json)

  # extract the token and granted scopes
  access_token = JSON.parse(result)['access_token']
  erb :signin
end


post "/" do
  @title = "GetThis2"

  if User.exists?(:username => params[:username])
    @user = User.find_by(username: params[:username])
    redirect "user/#{@user.id}"
  else
    @user = User.create(username: params[:username], password: params[:password])
    redirect "user/#{@user.id}"
  end
end

get "/user/:id" do
  @title = "Welcome User"
  @user = User.find(params[:id])

  erb :"/user/index"
end

get "/user/:id/lists" do
  @title = "Your Lists"
  @user = User.find(params[:id])

  @all_lists = []
  List.all.each do |x|
    if x.user_id == @user.id
      @all_lists << x
    end
  end

  erb :lists
end

get "/user/:id/lists/new" do
  @title = "New List"
  @user = User.find(params[:id])

  erb :"/user/lists/make_list" 
end

post "/user/:id/lists/new" do
  @title = "New List"
  @user = User.find(params[:id])
  @list = List.create(user_id: @user.id, name: params[:listname], keyword: params[:keyword])

  redirect "user/lists/#{@list.id}" 
end

get "/user/lists/:id" do
  @title = "My List"
  @list = List.find(params[:id])
  @title = "Add items"
  
  erb :"/user/lists/add_items"
end

post "/user/lists/:id" do
  @title = "Add Items"
  @list = List.find(params[:id])
  @item = Item.create(list_id: @list.id, name: params[:itemname], quantity: params[:quantity], completed: false)

  redirect "user/lists/#{@list.id}/items"
end

get "/user/lists/:id/items" do
  @title = "My List"
  @list = List.find(params[:id])

  @items = []
  Item.all.each do |x|
    if x.list_id == @list.id 
      @items << [x.name, x.quantity]
    end
  end 

  erb :"user/lists/display_list"
end


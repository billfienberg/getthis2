require 'rubygems'
require 'sinatra'
require 'sinatra/activerecord'

require_relative 'lib/db_checker.rb'
set :database, "sqlite3:///groceryapp.sqlite3"
require './models.rb'

get "/" do
  @title = "GetThis2"
  erb :index
end

post "/" do
  @title = "GetThis2"

  redirect "user/#{user.id}"
end

get "user/:id" do
  
end

get "/lists" do
  @title = "Your Lists"

  @all_lists = []
  List.all.each do |x|
    @all_lists << x
  end

  erb :lists
end

get "/lists/new" do
  @title = "New List"
   
  erb :"/lists/make_list" 
end

post "/lists/new" do
  @list = List.create(name: params[:listname], keyword: params[:keyword])

  redirect "lists/#{@list.id}" 
end

get "/lists/:id" do
  @list = List.find(params[:id])
  @title = "Add items"
  
  erb :"/lists/add_items"
end

post "/lists/:id" do
  @list = List.find(params[:id])
  @item = Item.create(list_id: @list.id, name: params[:itemname], quantity: params[:quantity], completed: false)

  redirect "lists/#{@list.id}/items"
end

get "/lists/:id/items" do
  @list = List.find(params[:id])

  @items = []
  Item.all.each do |x|
    if x.list_id == @list.id 
      @items << [x.name, x.quantity]
    end
  end 

  @title = "My Grocery List"

  erb :"/lists/display_list"
end


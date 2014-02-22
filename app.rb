require 'rubygems'
require 'sinatra'
require 'sinatra/activerecord'

require_relative 'lib/db_checker.rb'
set :database, "sqlite3:///groceryapp.sqlite3"
require './models.rb'

get '/' do
  erb :index
end

get '/make' do
  erb :make_list
end

post '/make' do
  puts params
  @list = List.new
  @list.name = params[:listname]
  @list.keyword = params[:keyword]
  @list.save

  redirect '/add_item'
end

get '/add_item' do
  @list = List.find(10)
  erb :made_list
end

post '/add_item' do
  puts params 
  @item = Item.new
  @item.name = params[:itemname]
  @item.quantity = params[:quantity]

  erb :made_list
end

get '/share' do
  
  erb :share_list
end

get '/lists' do
  
  erb :lists
end
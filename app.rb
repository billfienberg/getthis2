require 'rubygems'
require 'sinatra'
require 'sinatra/activerecord'

get '/' do
  erb :index
end

get '/make' do
  "Hi"
end

get '/share' do
  "Hello"
end

get '/lists' do
  "Howdy"
end
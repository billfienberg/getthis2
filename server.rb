require 'sinatra'

set :bind, '0.0.0.0' # Vagrant fix

get '/' do
  "lets hope this works"
end

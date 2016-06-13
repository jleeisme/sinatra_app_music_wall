# Homepage (Root path)
get '/' do
  erb :index
end

get '/songs' do
  'Look at all them songs'
end

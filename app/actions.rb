# Homepage (Root path)
# 
enable :sessions



helpers do
  def login?
    if session[:username].nil?
      redirect '/login'
    else
      return true
    end
  end

  def username
    return session[:username]
  end

end


get '/' do
  erb :index
end

post '/login' do
  @user = User.where(username: params[:username],
    password: params[:password])
    session[:username] = @user
end

get '/logout' do
  session[:username] = nil
  redirect '/'
end

get '/signup' do
  erb :signup
end

post '/signup' do
  @user = User.new(
    username: params[:username],
    password: params[:password]
    )
    @user.save
    redirect '/'
end

get '/songs' do
  @songs = Song.all
  if !session[:username].nil?
    erb :'songs'
  else
    redirect '/'
  end
end

get '/songs/new' do
  # login?
  erb :'songs/new'
end

post '/songs' do
  @song = Song.new(
    title:  params[:title],
    author: params[:author],
    url:    params[:url]
  )

  @song.save
  redirect '/songs'
end
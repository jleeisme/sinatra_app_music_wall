# Homepage (Root path)
# 
# enable :sessions...already enabled in environment

# need a helper to verify the user instead of looping through each time
# called within the gets
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

# search username and password to match the @user
# session will match the username
post '/' do
  @user = User.where(username: params[:username],
    password: params[:password])
    session[:username] = @user
end

# if the username value is nil, then they are logged out
# and redirect to '/'
get '/logout' do
  session[:username] = nil
# session.clear...removes everything from the hash
  redirect '/'
end

# needs the form inputed
get '/songs/signup' do
  erb :'songs/signup'
end

# new user has a username and password which is saved
# redirected to songs where they can then post songs etc.
post '/songs/signup' do
  @user = User.new(
    username: params[:username],
    password: params[:password]
  )
    @user.save
    redirect '/songs'
end

# if on the session the username isn't nil, songs is ok
# else redirected to index
get '/songs' do
  @songs = Song.all
  # if !session[:username].nil?
    erb :'songs/index'
  # else
  #   redirect '/'
  # end
end

get '/songs/new' do
  # login?
  erb :'songs/new'
end

# 
post '/songs/new' do
  @song = Song.new(
    title:  params[:title],
    author: params[:author],
    url:    params[:url]
  )
  @song.save
  redirect '/songs'
end
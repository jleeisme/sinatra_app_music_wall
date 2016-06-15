# Homepage (Root path)
helpers do
  def enforce_login
    unless session[:username]
      redirect '/login' 
    end
  end
  # def login?
  #   if session[:username].nil?
  #     redirect '/login'
  #   else
  #    true
  #   end
  # end

  # def username
  #   return session[:username]
  # end
end

get '/' do
  erb :index
end

# search username and password to match the @user
# session will match the username
post '/' do
  user = User.where(username: params[:username],
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
get '/signup' do
  current_user
  erb :'songs/signup'
end

# new user has a username and password which is saved
# redirected to songs where they can then post songs etc.
post '/signup' do
  user = User.new
  user.username = params[:username]
  user.password = params[:password]
  user.save!
  redirect '/songs'
end

get '/login' do
  if session[:username]
    redirect '/songs'
  end
  erb :'index'
end

post '/login' do
  user = User.find_by(username: params[:username])
  unless user
    redirect '/login'
  end
  if user.password == params[:password]
    session[:username] = user
    redirect '/songs'
  else
    redirect '/login'
  end
end
# if on the session the username isn't nil, songs is ok
# else redirected to index
get '/songs' do
  enforce_login
  # unless session[:username]
  #   redirect '/login'
  # end
  @song = Song.all
  # if !session[:username].nil?
  erb :'songs/index'
end

get '/songs/new' do
  current_user
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
  @song.save!
  redirect '/songs'
end

get '/songs/:id' do
  @song = Song.find params[:id]
  erb :'songs/show'
end

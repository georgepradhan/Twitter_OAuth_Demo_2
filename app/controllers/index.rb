get '/' do
  params[:username] ? redirect("/#{params[:username]}") : erb(:index)
end


get '/:username' do
  unless TwitterUser.find_by_username(params[:username])
    TwitterUser.create(username: params[:username])
  end

  @user = TwitterUser.find_by_username(params[:username])

  if @user.tweets_stale?
    @user.fetch_tweets!
  end

  @tweets = @user.tweets.limit(10)
  erb :_recent_tweets, layout: false # cuz i'm going to use this in ajax

end



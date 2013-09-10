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

post '/tweets' do
  #hardcode per instructions
  # @user = TwitterUser.create(username: "llorgenimhan")
  # @user.tweets.create(text: params[:user_tweet], tweet_time: Time.now)

  # The above are only needed if we wnat to write to database here.
  # Instead, we can make the choice that database writing will only
  # happen via the GET methods above.

  # The below sends the tweet out for the user configured in Environment
  # via OAuth Token and OAuth secret (which are hardcoded).
  Twitter.update(params[:user_tweet])
  redirect '/' unless request.xhr?
end

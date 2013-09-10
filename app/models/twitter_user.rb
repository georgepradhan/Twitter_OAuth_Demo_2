class TwitterUser < ActiveRecord::Base
  has_many :tweets

  # User#fetch_tweets! should make an API call
  # and populate the tweets table
  #
  # Future requests should read from the tweets table
  # instead of making an API call

  def most_recent_tweet
    self.tweets.sort_by(&:tweet_time).last
  end


  def last_tweet_time
    most_recent_tweet.tweet_time rescue Time.new(0)
  end


  def fetch_tweets!
    tweets = Twitter.user_timeline(self.username).select{|tweet| tweet.created_at > last_tweet_time}
      tweets.each do |tweet_obj|
        self.tweets.create(text: tweet_obj.text, tweet_time: tweet_obj.created_at)
      end
  end

  def tweets_stale?
    current_time = Time.now
    secs_lapsed = current_time - last_tweet_time
    secs_lapsed > (15*60)
  end

end

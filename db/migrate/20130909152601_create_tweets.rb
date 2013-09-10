class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.belongs_to :twitter_user
      t.string :text
      t.datetime :tweet_time

      t.timestamps
    end
  end
end

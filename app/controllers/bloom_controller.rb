class BloomController < ApplicationController

  def index
    @time = Time.now
  end

  def tweets
    tweeter = Tweeter.new

    # store an id from the last tweet referenced and the pass it to 
    # since_id: Tweet.last.tweet_id
 
    binding.pry

    tweets = tweeter.search("leopold bloom")


    tweets = tweets.reject do |tweet| 
      bots.include?(tweet.user.id) || tweet.retweet?
    end

    target_tweet = tweets.sample
    # binding.pry

    #tweeter =  Tweet.new(tweet_id: target_tweet.id)
    #tweeter.bloom_it
    #all this shit should be put up in a tweet class

  end

  private

  def bots
    [3104269506]
  end
end

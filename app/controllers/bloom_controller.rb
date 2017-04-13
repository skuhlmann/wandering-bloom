class BloomController < ApplicationController

  def index
    @time = Time.now
  end

  def tweets
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "QVNLl4Z6sluzG3GjqRyAUgtPs"
      config.consumer_secret     = "lq72z1eR8lsv6rgEz2w53Ef7My2zET6q1GHCpyaZJsHDHjzV95"
      config.access_token        = "722486936242290690-aUVtCpoTmFX8foOGGwSPFmd2XwQ0fdP"
      config.access_token_secret = "xxNjlExe6p2rzNcqlV6MSa10hxjm6uL7YysIhqJ3I4HRe"
    end

    # store an id from the last tweet referenced and the pass it to 
    # since_id: Tweet.last.tweet_id
    options = {
      result_type: "recent",
      lang: "en"
    }
    tweets = client.search("leopold bloom",  options)

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

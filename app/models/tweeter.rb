class Tweeter
  attr_accessor :client

  def initialize
    @client = connect_twitter
    @options = default_options
  end

  def search(term)
    @client.search(term,  @options)
  end

  private

  def connect_twitter
    Twitter::REST::Client.new do |config|
      config.consumer_key        = "QVNLl4Z6sluzG3GjqRyAUgtPs"
      config.consumer_secret     = "lq72z1eR8lsv6rgEz2w53Ef7My2zET6q1GHCpyaZJsHDHjzV95"
      config.access_token        = "722486936242290690-aUVtCpoTmFX8foOGGwSPFmd2XwQ0fdP"
      config.access_token_secret = "xxNjlExe6p2rzNcqlV6MSa10hxjm6uL7YysIhqJ3I4HRe"
    end
  end

  def default_options
    {
      result_type: "recent",
      lang: "en"
    }
  end
end

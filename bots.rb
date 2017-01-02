require 'twitter_ebooks'

class SVUBot < Ebooks::Bot
  def configure
    # Consumer details come from registering an app at https://dev.twitter.com/
    # Once you have consumer details, use "ebooks auth" for new access tokens
    self.consumer_key = '' # Your app consumer key
    self.consumer_secret = '' # Your app consumer secret

    # Users to block instead of interacting with
    self.blacklist = ['tnietzschequote']

    # Range in seconds to randomize delay when bot.delay is called
    self.delay_range = 1..6
  end

  def on_startup
    scheduler.every '24h' do
      # Tweet something every 24 hours
      # See https://github.com/jmettraux/rufus-scheduler
      # tweet("hi")
      # pictweet("hi", "cuteselfie.jpg")
    end
  end

  def on_follow(user)
    # Auto follow everyone
    follow(user.screen_name)
  end

  # def on_message(dm); end
  # def on_mention(tweet); end
  # def on_timeline(tweet); end
  # def on_favorite(user, tweet); end
  # def on_retweet(tweet); end
end

SVUBot.new("svu_ebooks") do |bot|
  bot.access_token = "" # Token connecting the app to this account
  bot.access_token_secret = "" # Secret connecting the app to this account
end

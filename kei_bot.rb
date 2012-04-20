#coding: utf-8

require 'twitter'
require './model.rb'
require './config/local_env.rb' unless ENV['OAUTH_TOKEN_SECRET']

class KeiBot
  def initialize
    Twitter.configure do |config|
      config.consumer_key       = ENV['CONSUMER_KEY']
      config.consumer_secret    = ENV['CONSUMER_SECRET']
      config.oauth_token        = ENV['OAUTH_TOKEN']
      config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
    end
  end

  def tweet
    t = Time.now.hour

    if t == 12
      return "#{random_word(Greeting, :greeting)}。#{jpn_wday}曜日で四男の慧です。"
    end

    random_word(Tweet, :tweet)
  end

  private
  def jpn_wday
    jpn_wday = %w[日 月 火 水 木 金 土]
    i = Time.new.wday
    jpn_wday[i]
  end

  def random_word(model, accessor)
    selected = model.where(:done => false).sample

    unless selected
      reset_tweets
      return random_word(model, accessor)
    end

    selected.done = true
    selected.save
    
    selected.send(accessor)
  end

  def reset_tweets
    Tweet.where(:done => true).update_all(:done => false)
  end
end

kei = KeiBot.new
=begin
begin
  Twitter.update(kei.tweet)
rescue
  retry
end
=end
p kei.tweet
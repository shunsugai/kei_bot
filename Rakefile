require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require './kei_bot.rb'
require './model.rb'

task :tweet do
  begin
    Twitter.update(KeiBot.new.tweet)
  rescue
    retry
  end
end

task :create do
  File.open('kei_bot_tweet.txt') do |tweet|
    while line = tweet.gets
      t = Tweet.new
      t.tweet = line.chomp
      t.save
    end
  end
end

task :done_all do
  Tweet.where(:done => false).update_all(:done => true)
end

task :check do
  p Tweet.where(:done => true).size
end
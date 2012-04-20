require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require './tweet.rb'

task :create do
  File.open('kei_bot.txt') do |tweet|
    while line = tweet.gets
      t = Tweet.new
      t.tweet = line
      t.save
    end
  end
end
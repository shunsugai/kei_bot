require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require './model.rb'

task :create do
  File.open('kei_bot_hello.txt') do |tweet|
    while line = tweet.gets.chomp
      t = Greeting.new
      t.greeting = line
      t.save
    end
  end
end
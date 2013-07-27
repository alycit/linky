require "./app"
require "sinatra/activerecord/rake"
require 'pry'

namespace :db do
  desc "Create the database"
  task :create do
    config = DB_CONFIG
    begin
      encoding = config[:encoding] || ENV['CHARSET'] || 'utf8'
      ActiveRecord::Base.establish_connection config.merge(:database => 'postgres', :schema_search_path => 'public')
      ActiveRecord::Base.connection.create_database config[:database], config.merge(:encoding => encoding)
      ActiveRecord::Base.establish_connection config
      puts "#{APP_NAME} DB Created!"
    rescue Exception => e
      $stderr.puts e, *(e.backtrace)
      $stderr.puts "Couldn't create database for #{config.inspect}."
    end
  end
  desc "Drop the database"
  task :drop do
    config = DB_CONFIG
    begin
      encoding = config[:encoding] || ENV['CHARSET'] || 'utf8'
      ActiveRecord::Base.establish_connection config.merge(:database => 'postgres', :schema_search_path => 'public')
      ActiveRecord::Base.connection.execute("DROP DATABASE #{APP_NAME};")
      puts "#{APP_NAME} DB Dropped!"
    rescue Exception => e
      $stderr.puts e, *(e.backtrace)
      $stderr.puts "Couldn't create database for #{config.inspect}."
    end
  end
  desc "Reload the DB"
  task :reload => ['db:drop', 'db:create']
end



ENV['BUNDLE_GEMFILE'] ||= File.expand_path('Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

require 'sinatra'
require 'sinatra/reloader' if development? 
require 'sinatra/contrib'

require 'pg'

require 'activesupport'
require 'activerecord'
require 'sinatra/activerecord'

require 'erubis'



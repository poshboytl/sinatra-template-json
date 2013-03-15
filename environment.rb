require 'rubygems'
require 'bundler/setup'
require 'sinatra' unless defined?(Sinatra)
# JSON Output
require 'oj'
require 'multi_json'

# Logger
use Rack::Logger
# Compress HTML using deflate / gzip
use Rack::Deflater

configure do 

  enable :logging, :dump_errors, :raise_errors

  set :root => File.dirname(__FILE__) # Avoid path scoping issues in tests
end

require 'rubygems'
require 'bundler/setup'
require 'csvision'
require 'test/unit'
require 'active_record'
require 'active_support'
require 'active_support/dependencies'
require 'turn'

include CSVision

TEST_PATH = File.expand_path( File.join File.dirname( __FILE__ ) )
config = YAML::load( IO.read( File.join TEST_PATH, 'config', 'database.yml' ) )['test']['sqlite']

ActiveRecord::Base.establish_connection config
ActiveSupport::Dependencies.autoload_paths.unshift File.join( TEST_PATH, 'app', 'models' )

ActiveRecord::Base.silence do
  ActiveRecord::Migration.verbose = false
  load File.join( TEST_PATH, 'db','schema.rb' )
end

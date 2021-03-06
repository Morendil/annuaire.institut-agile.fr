# Generated by cucumber-sinatra. (2011-05-30 13:22:39 +0200)
require 'dm-core'
require 'dm-migrations'

ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'lib/directory.rb')
require File.join(File.dirname(__FILE__), '..', '..', 'lib/roadmap.rb')

DataMapper.setup(:default, 'sqlite::memory:')
DataMapper.auto_migrate!

require 'capybara'
require 'capybara/cucumber'
require 'rspec'

Capybara.app = Directory

class DirectoryWorld
  include Capybara
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  DirectoryWorld.new
end

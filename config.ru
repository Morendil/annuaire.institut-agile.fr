require 'rubygems'
require 'datamapper'

require File.join(File.dirname(__FILE__), 'lib/directory.rb')

DataMapper.setup(:default, ENV['DATABASE_URL'])
DataMapper.auto_upgrade!

run Directory

require 'rubygems'
require 'datamapper'

require File.join(File.dirname(__FILE__), 'lib/annuaire.rb')

DataMapper.setup(:default, ENV['DATABASE_URL'])
DataMapper.auto_upgrade!

run Annuaire

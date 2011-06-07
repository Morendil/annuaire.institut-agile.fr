require 'dm-core'
require './lib/experience'

class Person
  include DataMapper::Resource

  property :id,		String,	:key => true
  property :first_name,	String
  property :last_name,	String
  property :since,	DateTime

  has n,   :experiences
end

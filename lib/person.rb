require 'dm-core'

class Person
  include DataMapper::Resource

  property :id,		String,	:key => true
  property :first_name,	String
  property :last_name,	String
  property :since,	DateTime
end

require 'dm-core'

class Experience
  include DataMapper::Resource

  belongs_to :person

  property :id,		Serial
  property :type,	String
  property :practice,	String

  def title
    Roadmap.find(@practice)["title"]
  end
end

require 'dm-core'

class Experience
  include DataMapper::Resource

  belongs_to :person

  property :id,		Serial
  property :type,	String
  property :practice,	String
  property :observed,	Text

  @@types = nil

  def title
    Roadmap.find(@practice)["title"]
  end
  
  def self.types
    @@types || @@types = File.open("views/types.yml") {|f| YAML::load(f)}  
  end

  def type_label
    which = Experience.types.find {|e| e[0]==@type} 
    which[1]
  end
end

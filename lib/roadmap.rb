require 'json'
require 'net/http'

class Roadmap
  @practices = JSON.parse(Net::HTTP.get("referentiel.institut-agile.fr","/index_json"))
  def self.add practice
    @practices << practice
  end
  def self.find id
    @practices.find {|i| i["id"]==id}
  end
  def self.all
    @practices
  end
  def self.options
    @practices.map {|each| [each["id"], each["title"]]}
  end
  def self.clear
    @practices = []
  end
end

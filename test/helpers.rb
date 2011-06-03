require 'linkedin'
require 'nokogiri'

def profile_for who
  who = who.gsub(" ","")
  doc = Nokogiri::XML(File.read("features/data/#{who}.xml"))
  profile = LinkedIn::Profile.new(doc)
end


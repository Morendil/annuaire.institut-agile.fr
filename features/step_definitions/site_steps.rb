require 'mocha'
require 'linkedin'
require 'nokogiri'

Given /^that I am not connected$/ do
end

Given /^that I am not registered$/ do
end

Given /^that I have authorized LinkedIn as "([^"]*)"/ do |who|
  who = who.gsub(" ","")
  doc = Nokogiri::XML(File.read("features/data/#{who}.xml"))
  profile = LinkedIn::Profile.new(doc)
  Annuaire.any_instance.stubs(:retrieve_profile).returns(profile)
end

Then /^I should be redirected within "([^"]*)"/ do |url|
  requested_url = page.driver.request.env['SERVER_NAME']
  requested_url.should match url
end

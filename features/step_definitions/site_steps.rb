require 'mocha'
require 'linkedin'
require 'nokogiri'

Then /^(?:|I )should see "([^\"]*)" in input "([^\"]*)"$/ do |text, selector| 
  selector = "//input[@name='#{selector}']/@value"
  if page.respond_to? :should
    page.should have_xpath(selector, :text => text)
  else
    assert page.has_xpath?(selector, :text => text)
  end
end

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

Then /^there should be a person "([^"]*)", "([^"]*)"/ do |first,last|
  Person.first(:first_name=>first,:last_name=>last).should_not be_nil
end

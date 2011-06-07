require 'mocha'
require './test/helpers'

After do
  Person.all.experiences.destroy
  Person.all.destroy
  Roadmap.clear
end

Then /^(?:|I )should see "([^\"]*)" in input "([^\"]*)"$/ do |text, selector| 
  selector = "//input[@name='#{selector}']/@value"
  if page.respond_to? :should
    page.should have_xpath(selector, :text => text)
  else
    assert page.has_xpath?(selector, :text => text)
  end
end

Given /^that I am not connected$/ do
  Directory.any_instance.unstub(:retrieve_profile)
end

Given /^that I am not registered$/ do
  person = Person.get(@profile.id) if @profile
  person.destroy if person
end

Given /^that I have authorized LinkedIn as "([^"]*)"/ do |who|
  @profile = profile_for who
  Directory.any_instance.stubs(:retrieve_profile).returns(@profile)
end

Given /^that I am registered as "([^"]*)"/ do |who|
  @profile = profile_for who
  Directory.any_instance.stubs(:retrieve_profile).returns(@profile)
  Person.get(@profile.id).destroy if Person.get(@profile.id)
  Person.create(
    :id=>@profile.id,
    :first_name=>@profile.first_name,
    :last_name=>@profile.last_name)
end

Given /^that there is a practice "([^"]*)" with title "([^"]*)"$/ do |id, title|
  Roadmap.add({"id"=>id,"title"=>title})
end

Given /^that I have added experience with "([^"]*)"$/ do |id|
  person = Person.get(@profile.id) 
  person.experiences.create(:practice => "stories") 
end

Given /^that there is a person "([^"]*)", "([^"]*)"/ do |first,last|
  Person.create(:id=>(first+last).hash,:first_name=>first,:last_name=>last)
end

Then /^I should be redirected within "([^"]*)"/ do |url|
  requested_url = page.driver.request.env['SERVER_NAME']
  requested_url.should match url
end

Then /^there should be a person "([^"]*)", "([^"]*)"/ do |first,last|
  Person.first(:first_name=>first,:last_name=>last).should_not be_nil
end

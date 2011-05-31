Given /^that I am not connected$/ do
end

Then /^I should be redirected within "([^"]*)"/ do |url|
  requested_url = page.driver.request.env['SERVER_NAME']
  requested_url.should match url
end

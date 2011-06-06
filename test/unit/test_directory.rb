require 'test/unit'
require 'timecop'
require 'rack/test'

require 'test/helpers'
require 'lib/directory.rb'


ENV['RACK_ENV'] = 'test'

class DirectoryTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Directory
  end

  def test_callback
    assert_equal "/done?backto=%2F", app.new!.callback('/')
  end

  def test_registration
    Timecop.freeze(Time.local(2011, 6, 3, 12, 0, 0))
    person = app.new!.register(profile_for "Laurent Bossavit")
    assert_equal "p4sWv6Bm4e", person.id
    assert_equal "Laurent", person.first_name
    assert_equal "Bossavit", person.last_name
    assert_equal Time.local(2011, 6, 3, 12, 0, 0), person.since.to_time
  end

  def test_layout_in_template_chains
    app.get('/foo') do
      haml (mustache "foo")
    end
    # Because we have a layout file...
    assert_not_equal "foo", get('/foo').body.strip
  end
end

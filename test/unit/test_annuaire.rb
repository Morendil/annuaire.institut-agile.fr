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

  def test__registration
    Timecop.freeze(Time.local(2011, 6, 3, 12, 0, 0))
    person = app.new.register(profile_for "Laurent Bossavit")
    assert_equal "p4sWv6Bm4e", person.id
    assert_equal "Laurent", person.first_name
    assert_equal "Bossavit", person.last_name
    assert_equal Time.local(2011, 6, 3, 12, 0, 0), person.since
  end

end

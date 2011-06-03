require 'test/unit'
require 'rack/test'

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

end

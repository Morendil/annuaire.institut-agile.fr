require 'test/unit'
require 'rack/test'

require 'lib/annuaire.rb'

ENV['RACK_ENV'] = 'test'

class AnnuaireTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Annuaire
  end

  def test_callback
    assert_equal "/done?backto=%2F", app.new!.callback('/')
  end

end

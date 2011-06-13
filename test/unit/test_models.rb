require 'test/unit'
require 'rack/test'
require 'mocha'

require 'test/helpers'
require 'lib/directory.rb'
require 'lib/experience.rb'

require 'dm-migrations'
DataMapper.setup(:default, 'sqlite::memory:')
DataMapper.auto_upgrade!
ENV['RACK_ENV'] = 'test'

class ModelTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Directory
  end

  def setup
    Person.all.destroy
    @current_user = Person.create(:id=>"foo")
    app.any_instance.stubs(:current_user).returns(@current_user)
  end

  def fixture_for type
    case type.to_s
      when "String" then "foo"
      else raise "Unhandled type"
    end
  end

  def alternate_for type
    case type.to_s
      when "String" then "bar"
      else raise "Unhandled type"
    end
  end

  def editable_properties type
    type.properties.select do |p|
      p.name != :id && (!p.name.to_s.end_with? "_id")
    end
  end

  def params_for props, &block
    params = {}
    props.each do |p|
      params[p.name] = block.call(p.primitive)
    end
    params
  end

  def assert_creates uri, type
    props = editable_properties type
    params = params_for props do |t| fixture_for t end
    post uri, params
    e = type.all.first

    assert_not_nil e
    props.each do |p|
      assert_equal(fixture_for(p.primitive),e.send(p.name.intern),
        "Bad: #{p.name}")
    end
  end

  def assert_updates uri, type
    props = editable_properties type
    instance = yield (params_for props do |t| fixture_for t end)

    post "#{uri}/#{instance.id}", (params_for props do |t| alternate_for t end)

    e = type.get(instance.id)
    assert_not_nil e
    props.each do |p|
      assert_equal(alternate_for(p.primitive),e.send(p.name.intern),
        "Bad: #{p.name}")
    end
  end

  def assert_deletes uri, type
    props = editable_properties type
    instance = yield (params_for props do |t| fixture_for t end)
    assert_not_nil type.get(instance.id)
    post "#{uri}/#{instance.id}"
    assert_nil type.get(instance.id)
  end

  # Tests all of CRUD except R...
  def test_experience_crud
    assert_creates '/profile/add',  Experience
    assert_deletes '/profile/delete', Experience do |params|
      @current_user.experiences.create(params)
    end
    assert_updates '/profile/edit', Experience do |params|
      @current_user.experiences.create(params)
    end
  end

end

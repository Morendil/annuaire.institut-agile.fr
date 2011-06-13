require 'test/unit'

require 'lib/helpers.rb'

class HelpersTest < Test::Unit::TestCase

  def test_select_tag_name
    result = select_tag :name=>:practice
    lines = result.split("\n")
    assert_equal "<select name='practice'>", lines.first
    assert_equal "</select>", lines.last
  end

  def test_select_tag_options
    options = [["tag","Label"]]
    result = (select_tag :name=>:practice, :values=>options)
    lines = result.split("\n")[1..-2]
    assert_equal "<option value='tag'>Label</option>", lines.first
  end

  def test_select_tag_current
    options = [["tag","Label"]]
    result = (select_tag :name=>:practice, :values=>options, :current=>"tag")
    lines = result.split("\n")[1..-2]
    assert_equal "<option selected='selected' value='tag'>Label</option>", lines.first
  end

  def test_select_tag_current_from_instance
    options = [["other","Quux"],["tag","Label"]]
    instance = Object.new
    def instance.practice
      "tag"
    end
    result = (select_tag :name=>:practice, :values=>options, :instance=>instance)
    lines = result.split("\n")[1..-2]
    assert_equal "<option selected='selected' value='tag'>Label</option>", lines.last
  end

end

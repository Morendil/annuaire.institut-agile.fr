def select_tag options
  values = options[:values] || []
  instance = options[:instance] 
  current = instance.send options[:name] if instance
  current = options[:current] || "" if !instance
  body = values.map {|each| select_tag_option each, current}
  body = body.join("\n")
  "<select name='#{options[:name]}'>\n#{body}\n</select>" 
end

def select_tag_option each, current
  selected = ""
  selected = "selected='selected' " if current == each[0]
  "<option #{selected}value='#{each[0]}'>#{each[1]}</option>"
end

class Roadmap
  @practices = []
  def self.add practice
    @practices << practice
  end
  def self.find id
    @practices.find {|i| i["id"]==id}
  end
  def self.all
    @practices
  end
  def self.clear
    @practices = []
  end
end

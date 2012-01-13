require 'haml'

class ViewHelper 
  
  def render(name, scope)
    template = File.read(SETTINGS.getEchoRoot + "/views/#{name}.haml")
    @engine = Haml::Engine.new(template)
    @engine.render(scope)
  end

end

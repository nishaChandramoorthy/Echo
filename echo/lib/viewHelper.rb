require 'haml'

class ViewHelper 
  
  def render(name, scope)
    template = File.read("views/#{name}.haml")
    @engine = Haml::Engine.new(template)
    @engine.render(scope)
  end

end

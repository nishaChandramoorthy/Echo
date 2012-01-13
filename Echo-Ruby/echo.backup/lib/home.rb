require 'singleton'
require 'viewHelper.rb'

class Home 
  include Singleton
 
  def initialize()
    @view = ViewHelper.new()
  end

  def view()
    @view.render('home', self)  
  end

end

HOME = Home.instance

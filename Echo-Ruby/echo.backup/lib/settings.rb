require 'singleton'

class EchoSettings 
  include Singleton

  def getMongoIP
    '192.168.208.204'
  end

  def getMongoPort
    '27017'
  end

  def getScalaIP
    '192.168.208.158'
  end

  def getScalaPort
    '1237'
  end

  def getEchoRoot
    '/home/sdslabs/EchoInstallations/Echo-Ruby/echo'
  end

  def filePath
    '/media/data/echo/files/'
  end

end

SETTINGS = EchoSettings.instance

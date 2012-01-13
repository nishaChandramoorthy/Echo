package sdslabs.echo.searching

import org.eclipse.jetty.server.Server
import org.eclipse.jetty.servlet._
import javax.servlet.ServletException
import javax.servlet.http._
import javax.servlet._
import org.eclipse.jetty.server.Request
import org.eclipse.jetty.server.handler.AbstractHandler
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse
import sdslabs.echo.searching._

object SearchingMain {
 
  
  def main(args : Array[String]) {
    var a : EchoSearching = new EchoSearching()
    var results = a.search("java a nutshell")
    println(results.toString())
    
    var server : Server = new org.eclipse.jetty.server.Server(1237)
    server.setHandler(new EchoServlet())
    server.start()
    server.join()

  }
  
}
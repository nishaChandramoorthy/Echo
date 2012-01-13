package sdslabs.echo.searching

import javax.servlet.http.HttpServlet
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse
import java.util.ArrayList
import org.json.JSONObject
import java.util.UUID
import java.io.PrintWriter
import org.eclipse.jetty.server.handler.AbstractHandler
import org.eclipse.jetty.server.Request
import scala.collection.JavaConversions._
import collection.immutable.ListMap

class EchoServlet extends AbstractHandler{

    override def handle(target: String, baseRequest: Request, request: HttpServletRequest , response:HttpServletResponse ){
     response.setContentType("application/json");
     response.setStatus(HttpServletResponse.SC_OK);
       var query=request.getParameter("query")
       var a : EchoSearching = new EchoSearching()
       var s_results = ListMap(a.search(query).toList sortBy{_._1}:_*)
      
       var jsonString = new String()
       
       s_results.values foreach ( a => {
    	 jsonString = "\"" + a + "\""  + jsonString
    	 jsonString = ", " + jsonString 
       })
       jsonString = "[" + jsonString
       jsonString += "]"
       jsonString = jsonString.replaceFirst(",", "")
       
       val out: PrintWriter = response.getWriter()
       out.print(jsonString);
       out.flush();
     
}
}
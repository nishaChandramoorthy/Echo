package com.sdslabs.echoClustering.Clustering
import hellotest.Hello

/**
 * @author ${user.name}
 */
object App {
  
  def foo(x : Array[String]) = x.foldLeft("")((a,b) => a + b)
  
  
  
  def main(args : Array[String]) {
    
    
    val a = new Hello()
    print(a.fun(13))
    println( "Hello World!" )
    println("concat arguments = " + foo(args))
  }

}

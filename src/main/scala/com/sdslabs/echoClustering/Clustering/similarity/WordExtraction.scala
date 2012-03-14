package com.sdslabs.echoClustering.Clustering.similarity

import java.util.UUID
import java.io.{FileInputStream, File}
import com.aliasi.util.ObjectToCounterMap
import com.aliasi.classify.PrecisionRecallEvaluation
import com.aliasi.cluster.HierarchicalClusterer
import com.aliasi.cluster.ClusterScore
import com.aliasi.cluster.CompleteLinkClusterer
import com.aliasi.cluster.SingleLinkClusterer
import com.aliasi.cluster.Dendrogram
import com.aliasi.util.Counter
import com.aliasi.util.Distance
import com.aliasi.util.Files
import com.aliasi.util.ObjectToCounterMap
import com.aliasi.util.Strings
import com.aliasi.tokenizer._

// vim: set ts=4 sw=4 et:
import com.sdslabs.echoClustering.Clustering.utils.EchoClusteringDocument
import similarity.BloomFilter

import scala.collection.mutable._

import org.apache.pdfbox.pdfparser.PDFParser
import org.apache.pdfbox.cos.COSDocument
import org.apache.pdfbox.util.PDFTextStripper
import org.apache.pdfbox.pdmodel.PDDocument



object WordExtraction {
        def main(args : Array[String])
        {
                    
        			
                                     
                    val dir : File = new File("/home/nisha/Books")
                    val lob : Array[File]= dir.listFiles()
                    val mobf = new HashMap[String,BloomFilter[Array[Byte]]]
                    
        			lob.foreach {
        			  book => {

        			    
        			    
                        val _id: UUID = UUID.randomUUID()
        			    val doc : EchoClusteringDocument = new EchoClusteringDocument(book, _id)
           			    val bf : BloomFilter[Array[Byte]] = doc.getBloomFilter
           			    println(bf.count())
           			    mobf.put(book.getName(),bf)
           			    
                        
                        
        			    
        			    
        			  }
        			  
        			}
        			  
        			  
        			
        			
        			
                    
                 
                }
        }

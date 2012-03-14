package com.sdslabs.echoClustering.Clustering.utils

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

import org.apache.pdfbox.pdfparser.PDFParser
import org.apache.pdfbox.cos.COSDocument
import org.apache.pdfbox.util.PDFTextStripper
import org.apache.pdfbox.pdmodel.PDDocument
import similarity.BloomFilter

/**
 * Created by IntelliJ IDEA.
 * User: nisha
 * Date: 6/3/12
 * Time: 11:23 AM
 * To change this template use File | Settings | File Templates.
 */

class EchoClusteringDocument(mFile: File, _id: UUID) {

  def id: UUID = _id

  val fi: FileInputStream  = new FileInputStream(mFile)
  val parser: PDFParser  = new PDFParser(fi)
  parser.parse();
  private val cd: COSDocument = parser.getDocument();
  private val stripper: PDFTextStripper = new PDFTextStripper();
  private val text: String  = stripper.getText(new PDDocument(cd));
  val falsePositiveProbability = 0.05
  val expectedSize = 10000

  val bloomFilter = new BloomFilter[Array[Byte]](falsePositiveProbability, expectedSize)



  val mTokenCounter : ObjectToCounterMap[String] = new ObjectToCounterMap[String]()

  private val factory: TokenizerFactory = IndoEuropeanTokenizerFactory.INSTANCE
  private val tokenizer = factory.tokenizer(text.toCharArray, 0, text.length)
  private var token : String = null
  
  token = tokenizer.nextToken()
  while( token != null){
    mTokenCounter.increment(token.toLowerCase())
    
    bloomFilter.add(token.getBytes())
      
    token = tokenizer.nextToken()
    
  }

  print(bloomFilter.count())
  var len_sum : Double = 0.0
  for( counter <- mTokenCounter.values().toArray[Counter](new Array[Counter](0))){
    len_sum += counter.doubleValue
  }

  val mLength: Double = len_sum

  def cosine(doc : EchoClusteringDocument) : Double = {
    var sum : Double = 0.0

    for( token <- mTokenCounter.keySet().toArray[String](new Array[String](0))) {
      val count: Int = doc.mTokenCounter.getCount(token)
      if( count != 0 ){
        sum += Math.sqrt( count * mTokenCounter.getCount(token))
      }
    }
    return sum / (mLength * doc.mLength)
  }
  def getBloomFilter : BloomFilter[Array[Byte]] = {
    return bloomFilter
  }


}

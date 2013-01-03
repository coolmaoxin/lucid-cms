package scrape

import org.jsoup.Jsoup
import org.jsoup.nodes.Document
import org.jsoup.select.Elements

import com.dogself.realestate.VisualTour
import grails.converters.deep.JSON

/**
 * Created by IntelliJ IDEA.
 * User: Sayagle
 * Date: Dec 3, 2010
 * Time: 11:20:30 PM
 * To change this template use File | Settings | File Templates.
 */
class VisualTourScraper {



  def VisualTourScraper() {

  }

  def List<VisualTour> scrapeListings(){
    String url = "http://www.visualtour.com/inventorymap.asp?cp=1&vt=2&u=19413";
    Document doc = Jsoup.connect(url).get();
    Elements scripts = doc.select("script");
    String start = "eval('(' + '";
    String end = "' + ')');"
    List<VisualTour> ret = [];
    scripts.each {
      it.data().eachLine { line ->
        if(line.indexOf(start) > -1){
          ret = fromJsonObject(JSON.parse(line.substring(line.indexOf(start)+start.length(), line.indexOf(end))))
        }
      }
    }
    return ret;
  }



  static <T> T createFromMap(Class<T> clazz, Map props) {
    T o = clazz.newInstance()
    props.each { k, v -> o."${k}" = v }
    o
  }

  def List<VisualTour> fromJsonObject(def map){
    List list = map["markers"];
    List ret =  list.collect {
      new VisualTour( it.findAll { k, v -> k in VisualTour.metaClass.properties*.name })
    }
    return ret;
  }

 

  
}

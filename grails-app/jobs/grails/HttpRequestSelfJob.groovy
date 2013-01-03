package grails

import org.codehaus.groovy.grails.commons.ConfigurationHolder

/**
 * In order to prevent stale hibernate connections, we will do this little hack and make an http request to myself every 20 mins
 */

class HttpRequestSelfJob {
  static transactional = false

  static int interval = 1000 * 60 * 60 * 4;

  static triggers = {

    simple name: 'requestSelf', startDelay: ((int)Math.random() * interval) , repeatInterval: interval
  }

  def group = "requestSelfGroup"

   def execute(){
     def url = ConfigurationHolder.config.domainName;
     println "pinging myself at: ${url}"
     URLConnection c  = new URL("http://"+url+"/admin/status").openConnection();
     c.connect();
     c = null;
   }
}

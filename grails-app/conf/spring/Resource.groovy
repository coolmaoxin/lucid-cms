import org.apache.commons.dbcp.BasicDataSource

beans = {
  dataSource(BasicDataSource) {
    //run the evictor every 30 minutes and evict any connections older than 30 minutes.
    minEvictableIdleTimeMillis=1800000
    timeBetweenEvictionRunsMillis=1800000
    numTestsPerEvictionRun=3
    //test the connection while its idle, before borrow and return it
    testOnBorrow=true
    testWhileIdle=true
    testOnReturn=true
    validationQuery="SELECT 1"
  }
} 
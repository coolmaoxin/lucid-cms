package grails

import scrape.VisualTourScraper
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import com.dogself.realestate.VisualTour


class ScrapeJob {

   def adminService

  static triggers = {
     cron name: 'scrapeTrigger', cronExpression: "0 2 0 * * ?"
  }
  def group = "scrapeGroup"

  VisualTourScraper vtScraper = new VisualTourScraper()

  def execute() {
    if(adminService.getSiteComponents().visualTours){
        List<VisualTour> scrape = vtScraper.scrapeListings();
        VisualTour.list().each {
          it.delete() //remove the old data
        }
        scrape.each {
          it.save() //add the latest scraped data
        }
        ConfigurationHolder.config.info["lastVtScrape"] = new Date();
        ConfigurationHolder.config.info["vtScrapeRecords"] = scrape.size();
        scrape = null
    }
  }
}

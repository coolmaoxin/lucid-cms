package com.dogself.core

class SiteComponent {

    static constraints = {
        visualTours(nullable:false)
        mls(nullable:false)
        products(nullable:false)
        contact(nullable:false)
        login(nullable:false)
    }

    boolean visualTours = false //scrape
    boolean mls = false//scrape and a search nav
    boolean products = false
    boolean contact = false //show contact nav
    boolean login = true//show login nav (or dont show it if there is custom link somewhere)

    boolean guestbook = false//allow user to define custom fields and have guestbooks

}

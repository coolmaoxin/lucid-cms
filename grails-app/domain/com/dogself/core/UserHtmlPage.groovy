package com.dogself.core

class UserHtmlPage {

    static constraints = {
        html(blank: true)
        html(maxSize:1024000)
    }

    String html

  //  static belongsTo = [nav: Navigation]

}

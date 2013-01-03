package com.dogself.core

/**
 * unlike userHtmlPage which is a whole page, this can be placed anywhere via a tag, and refereced by name
 */
class UserEditableSection{

    static constraints = {
        html(blank: true)
        html(maxSize:1024000)
    }

    String html
    String name //the tag will use this to look it up

}

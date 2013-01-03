package com.dogself.blog

class GuestbookEntry {

    static constraints = {
        comment type: 'text'
        comment(nullable:true)
    }
    
    static mapping = {
        sort "dateCreated"
    }

    Date dateCreated
    Date lastUpdated

    String name;
    String comment = "";

    Map<String,String> fields; //extra feilds can be whatever you want, just validate them yourself
}

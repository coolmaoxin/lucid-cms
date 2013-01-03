package com.dogself.core

import com.dogself.merchant.Product

class Navigation {
    Navigation parent
    List children = new ArrayList();
    UserHtmlPage userHtml;

    String name; //text that appaers on tab name
    String urlPath; //SEOd name (About Me = about-me)
    String navigationHeading; //if this nav contains children, this will be that nav's heading

    List<Product> products = new ArrayList();//do not cascade deletes to these !

    boolean active
    boolean showInNav

    static belongsTo = [parent: Navigation]
    static hasMany = [children: Navigation, products: Product]
    static fetchMode = [children:"eager"]

    static transients = ["crumb"]

    static constraints = {
        parent(nullable: true);
        children(nullable: true);
        urlPath(nullable: true);
        userHtml(nullable: true);
        navigationHeading(nullable: true);
    }

    public String toString(){
        return name;
    }

    //returns the full path to nav in form:
    //Home > Stuff > Things
    public String getCrumb(String seperator = " > "){
        if(parent.parent == null){
            return name//this is right under root
        } else {
            return parent.getCrumb() + seperator + name
        }
    }
}

package com.dogself.core

import org.codehaus.groovy.grails.commons.ConfigurationHolder
import com.dogself.core.Navigation
import com.dogself.core.UserHtmlPage

class NavigationService {

    static transactional = true

    def contactService
    def springSecurityService
    def adminService
    def productService


    Navigation getRootNavigation() {
        Navigation root = Navigation.findByParentIsNull();
        return root;
    }

    /**
     * returns all naviation items that user didnt create
     * @return
     */ 
    List getCustomNavigation(){
        Navigation root = getRootNavigation();
        SiteComponent comp = adminService.getSiteComponents();
        List navs = []
        List<CustomNavigation> cust = CustomNavigation.findAllBySite(ConfigurationHolder.config.siteName);
        cust.each {
            navs << new Navigation(parent:root, name:it.name, urlPath:it.urlPath, active: true)
        }
        navs.addAll([
            //TODO: later i want to be able to have a 'sort' table where sorts will be defined by nav.id
            new Navigation(parent:root, name:"Search Listings", urlPath:"search-listings", active: comp.mls),
            new Navigation(parent:root, name:"Contact", urlPath:"contact", active: comp.contact),
            new Navigation(parent:root, name:"Log In", urlPath:"login", active: (comp.login && !springSecurityService.isLoggedIn())),
            new Navigation(parent:root, name:"Admin", urlPath:"admin", active: adminService.isAdmin(springSecurityService.currentUser)),

        ])

        int fakeId = 1000000;
        for(Navigation n : navs){
            n.setId(fakeId++)
        }
        return navs;
    }

    /**
     * Attach a Navigation item to the nav tree, if parentId is null, add this Navigation to root
     *
     * NOTE: to get errors you need to look in toSave.parent (since parent is saved)
     * 
     * @param toSave
     * @param parentId
     * @param parentNavigationHeading = the children of the parent will be under this nav heading
     * @return
     */
    Navigation addNavigationToTree(Navigation toSave, String parentId = null, String parentNavigationHeading = ""){
        Navigation parent;
        if(parentId){
            parent = Navigation.findById(Long.valueOf(parentId));
            parent.setNavigationHeading(parentNavigationHeading)
        } else {
            parent = this.getRootNavigation();
        }

        if(Navigation.findByUrlPath(toSave.urlPath) != null){ //prevent from 2 identical url paths from existing
            toSave.urlPath += "2"; //TODO make this a bit more smart to prevent 'test2222222' type urls
        }
        parent.addToChildren(toSave);

        UserHtmlPage parentHtml = parent.getUserHtml();
        if(parentHtml == null){
            def html = new UserHtmlPage(html:"")
            toSave.setUserHtml(html); //the parent wasnt a leaf already, so make me some new html
            html.save(flush: true)
            toSave.save(flush: true)
        } else { //move the parent html reference down to the leaf because non-leafs cant have html
            parent.userHtml = null;
            toSave.userHtml = parentHtml;
            //also move any products from the parent down to the leaf
            productService.moveProducts(parent, toSave);
        }

        parent.save(flush:true); //the crux of the matter: always save the parent and let the changes cascade down
        return toSave;
    }

    /**
     * Remove a navigation from the tree, if its removal will make its parent a leaf, the userHtml is copied to parent.
     * Parent OR NULL is returned, since the errors live in the parent instance. Null returned when navId doesnt find anything
     *
     * You cannot delete ROOT node with this method
     *
     * @param navId
     * @param deleteLeavesOnly = if false, you can remove any node, even if it has children
     * @return
     */
    Navigation removeNavigationFromTree(String navId, boolean deleteLeavesOnly = true){
        if(navId.matches("\\d+")){
            Long id = Long.parseLong(navId);
            Navigation byeBye = Navigation.findByIdAndParentIsNotNull(id);

            if(deleteLeavesOnly && byeBye.children.size() > 0){
                return null; //not allowed to delete non-leaf nodes if 'deleteLeavesOnly'
            }
            
            if(byeBye != null){
                Navigation parent = byeBye.parent;
                if(parent.parent != null){ //do the following only if nav thats being deleted is NOT a child of root
                    UserHtmlPage page = byeBye.getUserHtml();
                    if(parent.children.size() == 1){ //copy the html only if this is the last child of that nav to be deleted
                       parent.setUserHtml(new UserHtmlPage(html:page.html));
                    }
                }
                productService.deleteAllProducts(byeBye);
                parent.removeFromChildren(byeBye);
                byeBye.delete();
                parent.save();
                return parent;
            }
        }
        return null;
    }

    //this one is simple!
    Navigation updateNavigation(Navigation n){
        return n.save()
    }

    List getTopNavigation() { //get top navigation (children of root)
        List userNav = getRootNavigation().children;
        List customNav = getCustomNavigation();
        List allNav = [];
        allNav.addAll(userNav);
        allNav.addAll(customNav);
        return allNav;
    }

    String getDefaultNav() { //if no nav is asked for, show this one
        getTopNavigation().first();
    }

    Navigation findLeaf(Navigation nav){ //find a leftmost leaf from this node
        Navigation leaf = nav;
        while(leaf.getChildren().size() > 0){
            leaf = (Navigation)leaf.getChildren().get(0)
        }
        return leaf;
    }

    List<Navigation> getLeaves(){
        return Navigation.findAll().findAll {
            it.children.size() == 0
        }
    }

    //starting at nav, get all the parents until root
    List<Navigation> getBreadCrumb(Navigation nav) {
        List crumb = [nav]
        Navigation parent;
        while(nav.getParent().getParent() != null){ //dont want the root node
            parent = nav.getParent();
            crumb << parent
            nav = parent;
        }
        return crumb.reverse()
    }

    def getPageTitle(page = getDefaultNav().name) {
        ConfigurationHolder.config.siteTitle + " :: " + page
    }

    //this one is called by controllers that want to inject the PAGE model into their model
    def setupModelForPage(String urlPath, Map model) {
        model.putAll(getModelForPage(urlPath))
        return model;
    }

    Map getModelForPage(String urlPath) {
        Navigation nav;

        nav = getNavigationForUrlPath(urlPath)
          /*
      strategy of generating the navigation for the page
      - find the nav they clicked on (done above)
      - get leaf of that nav (defualt is 1st child of every parent)
      - get breadcrumb to leaf
      - get top nav
      - get left nav via breadCrumb[0].children
           */

        Navigation leaf = findLeaf(nav)
        List<Navigation> breadCrumb = getBreadCrumb(leaf)
        List<Navigation> topNav = getTopNavigation()
        List<Navigation> leftNav = breadCrumb.get(0).getChildren()

        return [
                "topNav": topNav,
                "leftNav": leftNav,
                "leaf": leaf,
                "breadCrumb": breadCrumb,
                "title": getPageTitle(nav.getName()),
                "siteConfig":  adminService.getSiteConfig(),
                "siteComponents":  adminService.getSiteComponents(),
                "siteName": ConfigurationHolder.config.siteName //used for templating
        ];
    }

    /**
     * returns the proper nav or a proper default 
     * @param urlPath
     * @return
     */
    public Navigation getNavigationForUrlPath(String urlPath) {
        Navigation nav
        if (urlPath == null) {
            nav = getRootNavigation().children.get(0);//first nav item of root
        } else {
            nav = Navigation.findByUrlPath(urlPath)
        }
        if (nav == null) { //its not in db, it must be custom navigation
            List customNav = getCustomNavigation();
            nav = customNav.find {
                return it.urlPath == urlPath
            }
        }
        if (nav == null) { //urlPath was not null, but it was wrong anyway..
            nav = getRootNavigation().children.get(0);//first nav item of root
        }
        return nav
    }


}

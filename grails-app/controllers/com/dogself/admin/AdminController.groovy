package com.dogself.admin

import com.dogself.core.User
import grails.plugins.springsecurity.Secured
import com.dogself.core.UserHtmlPage
import com.dogself.core.Navigation
import com.dogself.util.CollectionUtils
import org.springframework.validation.FieldError
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import com.dogself.core.SiteConfig
import org.springframework.web.servlet.ModelAndView
import com.dogself.core.UserEditableSection
import com.dogself.merchant.Product
import com.dogself.core.SiteComponent

/**
 * this controller will handle initial site setup tasks, and performance monitoring
 */
class AdminController {

    def springSecurityService
    def adminService
    def navigationService
    def userService
    def productService

    def afterInterceptor = [action: this.&injectModel]

    def obj = "test"

    private Map injectModel(Map model) {
        navigationService.setupModelForPage("admin", model)
    }

    /**
     *  when there is no admin, you can create an admin user in /admin/status
     */
    def firstTimeSetup = {
        SiteConfig config = adminService.getSiteConfig();
        if (!config.adminCreated) {
            User user = params
            user.enabled = true;
            User existingUser = User.findByUsername(user.username);
            if(existingUser){   //this shouldnt happen unless things go wromng
                userService.deleteUser(existingUser)
            }
            user = userService.createUser(user)

            adminService.makeUserAdmin(user)
            config.adminCreated = true;
            adminService.updateSiteConfig(config);

            SiteComponent siteComponentInstance = adminService.getSiteComponents()

            siteComponentInstance.properties = params
            if (!siteComponentInstance.hasErrors() && siteComponentInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'siteComponent.label', default: 'SiteComponent'), siteComponentInstance.id])}"

            }
        }

        redirect(action: "status")
    }

    /**
     * show memory status and such AND allow users to become admins if there are no admins in db
     * url path:
     * /setup
     */
    def status = {
        //find out if we have an admin yet?
        SiteConfig config = adminService.getSiteConfig();
        def siteComponentInstance = adminService.getSiteComponents()

        return [
                haveAdmin: config.adminCreated,
                siteComponentInstance: siteComponentInstance
        ]
    }

    /**
     * this is the entry point for admin tab stuff
     */
    @Secured(['ROLE_ADMIN'])
    def admin = {
        return [
                "hasSections": UserEditableSection.list()?.size() > 0
        ];
    }

    /**
     * edit a user html page, step 1
     */
    @Secured(['ROLE_ADMIN'])
    def editUserHtml = {
        return new ModelAndView("/admin/editHtml", [
                "pages": Navigation.findAllByUserHtmlIsNotNull(),
                "which": "page"
        ])
    }

    @Secured(['ROLE_ADMIN'])
    def editSection = {//edit a UserEditableSection
        return new ModelAndView("/admin/editHtml", [
                "pages": UserEditableSection.list(),
                "which": "section"
        ]);
    }

    @Secured(['ROLE_ADMIN'])
    def editHtmlAjax = {//SAVE edits of a section or a page
        def editableHtml;
        if (params.which == "section") {
            editableHtml = UserEditableSection.findById(Long.parseLong(params.id))
        } else {
            editableHtml = UserHtmlPage.findById(params.id);
        }
        editableHtml.setHtml(params.html)
        editableHtml.save(flush: true)
        render(contentType: "text/json") {
            ["success": !editableHtml.hasErrors(), "error": getErrorsAsString(editableHtml)]
        }
    }

    @Secured(['ROLE_ADMIN'])
    def createNavigation = { //shows a page to create a new top nav, or child nav
        List nonRootNavs = Navigation.findAllByParentIsNotNull();
        def navigationHeadings = [];
        List allowedNavs = []; //we cant allow them to create navs deeper then 'maxNavigationLevels'
        nonRootNavs.each { Navigation nav ->
            navigationHeadings[(int) nav.id] = nav.navigationHeading;
            if (navigationService.getBreadCrumb(nav).size() < ConfigurationHolder.config.maxNavigationLevels) {
                allowedNavs << nav;
            }
        }
        return [
                "navs": allowedNavs,
                "navigationHeadingsJson": navigationHeadings.encodeAsJSON()
        ]
    }

    @Secured(['ROLE_ADMIN'])
    def createNavigationAjax = { //when user makes a new nav, they make an ajax request here
        Navigation n = params;
        n.active = params.parentId != null;  //parent id is not supplied if they select the checkbox to not show in nav
        n = navigationService.addNavigationToTree(n, params.parentId, params.parentNavigationHeading);

        String error = "";
        boolean success = true;
        if (n.parent.hasErrors()) { //we save the parent, so it will have errors
            error = getErrorsAsString(n.parent);
            success = false;
        }

        render(contentType: "text/json") { //they might need the htmlId for redirecting to the edit page for the html
            ["success": success, "error": error, "htmlId": n.getUserHtml()?.id]
        }
    }

    @Secured(['ROLE_ADMIN'])
    def deleteNavigation = { //shows delete nav page to user
        List pages = [];
        Navigation.findAllByUserHtmlIsNotNull().each { Navigation nav ->
            List crumb = navigationService.getBreadCrumb(nav)
            String name = CollectionUtils.join(crumb, " > ");
            pages << ["name": name, "id": nav.getId(), "numProducts":nav.products.size()];
        }

        return [
                "pages": pages
        ]
    }

    @Secured(['ROLE_ADMIN'])
    def deleteNavigationAjax = { //ajax action used to remove navs
        Navigation parent = navigationService.removeNavigationFromTree(params.id);
        boolean success = false;
        String error = "";
        if (parent != null) {
            if (!parent.hasErrors()) {
                success = true;
            } else {
                error = getErrorsAsString(parent);
            }
        } else {
            error = "Navigation.id passed in doesnt not exist. Refresh page and try again"
        }
        render(contentType: "text/json") { //they might need the htmlId for redirecting to the edit page for the html
            ["success": success, "error": error]
        }
    }

    @Secured(['ROLE_ADMIN'])
    def renameNavigation = {
        return [
                "pages": Navigation.findAllByParentIsNotNull()
        ]
    }

    @Secured(['ROLE_ADMIN'])
    def renameNavigationAjax = {
        Long id = Long.parseLong(params.id);
        String name = params.name;
        String urlPath = params.urlPath;
        Navigation nav = Navigation.findById(id);
        String error = "Page not found, please refresh page and try again";
        boolean success = false;
        if (nav != null && name != "" && urlPath != "") {
            nav.name = name;
            nav.urlPath = urlPath;
            nav = navigationService.updateNavigation(nav);
            error = getErrorsAsString(nav);
            success = !nav.hasErrors();
        }
        render(contentType: "text/json") { //they might need the htmlId for redirecting to the edit page for the html
            ["success": success, "error": error]
        }
    }

    @Secured(['ROLE_ADMIN'])
    def editMetaData = {//edit <meta> tag contents
        return [
                "siteConfig": adminService.getSiteConfig()
        ]
    }

    @Secured(['ROLE_ADMIN'])
    def editMetaDataSubmit = {//submit of the above action
        SiteConfig conf = adminService.getSiteConfig()
        conf.getMetaTags()["description"] = params.description
        conf.getMetaTags()["keywords"] = params.keywords
        conf.getMetaTags()["googleApps"] = params.googleApps
        adminService.updateSiteConfig(conf)
        flash.message = "Meta-data saved"
        return new ModelAndView("/admin/editMetaData", editMetaData())

    }

    @Secured(['ROLE_ADMIN'])
     def editSiteConfig = {//edit <meta> tag contents
         return [
                 "siteConfig": adminService.getSiteConfig()
         ]
     }

     @Secured(['ROLE_ADMIN'])
     def editSiteConfigSubmit = {//submit of the above action
         SiteConfig conf = adminService.getSiteConfig()
         conf.setHeaderFont(params.headerFont)
         adminService.updateSiteConfig(conf)
         flash.message = "Saved"
         return new ModelAndView("/admin/editSiteConfig", editMetaData())

     }



    @Secured(['ROLE_ADMIN'])
    def editMlsConfig = {//edit <meta> tag contents
        return [
                "siteConfig": adminService.getSiteConfig()
        ]
    }

    @Secured(['ROLE_ADMIN'])
    def editMlsConfigSubmit = {//submit of the above action
        SiteConfig conf = adminService.getSiteConfig()
        conf.mlsUsername = params.mlsUsername
        conf.mlsPassword = params.mlsPassword
        adminService.updateSiteConfig(conf)
        flash.message = "Username and password have been updated"
        return new ModelAndView("/admin/editMlsConfig", editMlsConfig())

    }

    @Secured(['ROLE_ADMIN'])
    def createProduct = {//create new product
        return new ModelAndView("/admin/manageProducts", [
            "navs": navigationService.getLeaves(),
            "createNew":true
        ])
    }

    @Secured(['ROLE_ADMIN'])
    def editProduct = {//edit existing product
        return new ModelAndView("/admin/manageProducts", [
            "navs": navigationService.getLeaves(),
            "products": Product.findAll(),
            "createNew":false
        ])
    }


    @Secured(['ROLE_ADMIN'])
    def createOrUpdateProductSubmit = { //submit coming from createProduct or editProduct
       
        Long productId = params.getLong("productId"); //if this id exists, we are updating an EXISTING product
        Navigation parentNav;
        if(productId){
            Product updateMe = Product.findById(params.productId);
            updateMe.properties = params
            //save and move to a new navigation if needed
            parentNav = productService.saveProduct(updateMe, params.getLong("navigationId")); //parent holds the errors
        } else {
            Product p = params;
            p.active = true;
            parentNav = productService.saveProduct(p, params.getLong("navigationId")); //parent holds the errors
            productId = p.id;
        }
        if (parentNav.hasErrors()) {
           //TODO send me an email with stacktrace
           flash.message = "There was a problem creating the product."
           return createProduct()
        }
        //there is more then one submit button that gets us here:
        if (params.manageImages) {
            return new ModelAndView("/admin/manageProductImages", getManageProductImagesModel(productId))
        } else if(params.createMore){
            flash.message = "Product saved.";
            return createProduct()
        } else if(params.saveAndExit){
            return new ModelAndView("/admin/admin", admin())
        }
    }

    @Secured(['ROLE_ADMIN'])
    def editProductAjax = {//ajax in an editable product html (from createOrUpdateProductSubmit) when they select different products from the dropdown, this method returns the editable product meat
        Product p = Product.findById(params.id);
        render(template: "/templates/admin/editProduct", model: ["p":p, "navs": navigationService.getLeaves()])
    }

    @Secured(['ROLE_ADMIN'])
    def setMainProductImageAjax = {//ajax to set the main product image (from manageProductImages)
        Product p = Product.findById(params.getLong("productId"));
        p.mainProductImageName = params.imageName
        productService.updateProduct(p)
        render(contentType:"text/json") {
            [success:true]
        }
    }

    @Secured(['ROLE_ADMIN'])
    def removeProductImageAjax = {//ajax to delete a product image (from manageProductImages)
        boolean deleted = productService.deleteProductImage(params.getLong("productId"), params.imageName)
        render(contentType:"text/json") {
            [success:deleted]
        }
    }

    @Secured(['ROLE_ADMIN'])
    def deleteProduct = {//delete a product
        return [
            "products": Product.findAll()
        ]
    }

    @Secured(['ROLE_ADMIN'])
    def deleteProductSubmit = {//edit existing product
        Navigation parent = productService.deleteProduct(params.getLong("productId"));
        //todo error checking
        render(contentType: "text/json") { //they might need the htmlId for redirecting to the edit page for the html
            ["success": true]
        }
    }

    @Secured(['ROLE_ADMIN'])
    def manageProductImages = { //screen where user uploads or deletes product images
        getManageProductImagesModel(params.id)
    }

    @Secured(['ROLE_ADMIN'])
    def moveProducts = { //move one or more products from one nav to another nav
        List<Navigation> navs = navigationService.getLeaves();
        Map map = [:]
        navs.each {
            List list = [];
            it.products.each { Product p ->
                list << ["id":p.id,"name":p.name]
            }
            map[it.id] = list;
        }
        ["navs":navs,
         "map": map.encodeAsJSON()]
    }

    @Secured(['ROLE_ADMIN'])
    def moveProductsSubmit = {
        def productIds = params.productIds.split(",");
        Long toId = params.getLong("toId")
        int moveCount = 0;
        productIds.each { String pid ->
            Boolean doMove = params.getBoolean(pid);
            if(doMove){
                Long id = Long.parseLong(pid.substring(2));
                Product toMove = Product.findById(id);
                Navigation nav = Navigation.findById(toId);
                productService.moveProduct(toMove, nav);
                moveCount++;
            }
        }
        flash.message = moveCount +" Products Moved";
        redirect(action:"moveProducts")
    }

    @Secured(['ROLE_ADMIN'])
    def rotateProductImageAjax = {
        boolean success = productService.rotate(params.imageName, params.getLong("productId"), params.getBoolean("clockwise"))
        render(contentType: "text/json") {
            ["success": success]
        }
    }

    private def getManageProductImagesModel(Long productId) {
        ["product": Product.findById(productId),
          "images": productService.getProductImageFilenames(productId)]
    }

    String getErrorsAsString(def obj) {
        String error = "";
        obj.getErrors().getFieldErrors().each { FieldError e ->
            error += e.toString() + ",\n";
        }
        return error;
    }
}

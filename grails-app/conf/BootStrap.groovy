import com.dogself.core.Role
import com.dogself.core.User
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import com.dogself.core.Navigation
import org.springframework.aop.target.HotSwappableTargetSource
import org.codehaus.groovy.grails.web.mapping.DefaultUrlMappingsHolder
import org.codehaus.groovy.grails.web.mapping.UrlMappingsHolder
import org.codehaus.groovy.grails.commons.GrailsClass
import org.codehaus.groovy.grails.commons.DefaultGrailsUrlMappingsClass
import org.codehaus.groovy.grails.web.mapping.UrlMappingEvaluator
import org.codehaus.groovy.grails.web.mapping.DefaultUrlMappingEvaluator
import org.springframework.context.ApplicationContext
import org.codehaus.groovy.grails.web.servlet.GrailsApplicationAttributes
import com.dogself.CustomNavigationMap
import org.codehaus.groovy.grails.web.mapping.UrlMapping
import org.codehaus.groovy.grails.web.servlet.mvc.GrailsUrlHandlerMapping

class BootStrap {

    def emailConfirmationService
    def grailsApplication
    def mailService
    def contactService
    def navigationService
    def productService
    def grailsUrlMappingsHolder

    def init = { servletContext ->


    ApplicationContext applicationContext = servletContext.getAttribute(GrailsApplicationAttributes.APPLICATION_CONTEXT)

        emailConfirmationService.onConfirmation = { email, uid ->
            User user = User.findByUsername(email);
            contactService.sendEmailToSiteOwner("website mls search registration", """
        Name: ${user.name}
        Email: ${user.username}
        Zip: ${user.zip}
        Phone: ${user.phone}
        This user has registered and confirmed their email address.
      """)

            user.enabled = true;
            user.save(flush: true)
            return [controller: 'user', action: 'confirmWelcome']
        }
        emailConfirmationService.onInvalid = { uid ->
            return [controller: 'user', action: 'confirmInvalid']
        }
        emailConfirmationService.onTimeout = { email, uid ->
            return [controller: 'user', action: 'confirmInvalid']
        }
        ConfigurationHolder.config.info.appStartTime = new Date();


        if(navigationService.getRootNavigation() == null){ // root nav does not exist, we need it! insert it now
            Navigation root = new Navigation(name: "root", active: true);
            root.save(flush:true, failOnError:true);
            Navigation home = new Navigation(name: "Home", active: true, urlPath: "home");
            navigationService.addNavigationToTree(home);
        }
        
        if(Role.findByAuthority("ROLE_ADMIN") == null){
            new Role(authority: 'ROLE_ADMIN').save(flush: true)
        }
        if(Role.findByAuthority("ROLE_USER") == null){
            new Role(authority: 'ROLE_USER').save(flush: true)
        }

        
        def mapping = "com.dogself.CustomNavigationMap_${ConfigurationHolder.config.siteName}"
        try {
            CustomNavigationMap mappingInst = this.class.classLoader.loadClass(mapping).newInstance()
            mappingInst.createCustomNavIfNeeded();
        } catch (ClassNotFoundException e){
            println "no custom (as in programmed per site) tabs on this site"
        }

//        List<UrlMapping> urlMappings = grailsUrlMappingsHolder.urlMappings as List
//        urlMappings.addAll(getUrlMappingsForClass(mappingInst.class)) //add any of the custom mappings
//        HotSwappableTargetSource ts = applicationContext.getBean('urlMappingsTargetSource')
//        UrlMappingsHolder mappings = new DefaultUrlMappingsHolder(urlMappings)
//
//        ts.swap(mappings)
//
        println "wooosh"
    }
    def destroy = {
    }

    private List getUrlMappingsForClass(mappingClass) {
        GrailsClass grailsClass = new DefaultGrailsUrlMappingsClass(mappingClass)
        UrlMappingEvaluator evaluator = new DefaultUrlMappingEvaluator()
        return evaluator.evaluateMappings(grailsClass.getMappingsClosure())
    }
}

/**
 * An apex page controller that exposes the site login functionality

global with sharing class CommunitiesLoginController {

    global CommunitiesLoginController () {}
    
    // Code we will invoke on page load.
    global PageReference forwardToAuthPage() {
    	String startUrl = System.currentPageReference().getParameters().get('startURL');
    	String displayType = System.currentPageReference().getParameters().get('display');
        return Network.forwardToAuthPage(startUrl, displayType);
    }
    global PageReference forwardToCustomAuthPage() {
        return new PageReference('/CustomLoginPage'); 
    }
}  */

global with sharing class CommunitiesLoginController {

 public String password { get; set; }

 public String username { get; set; }

 global CommunitiesLoginController () {}

 global PageReference forwardToAuthPage() {

 String startUrl = System.currentPageReference().getParameters().get('startURL');

 String displayType = System.currentPageReference().getParameters().get('display');

 return Network.forwardToAuthPage(startUrl, displayType);

 }

 global PageReference RedirectToLogin()

 {

 return new PageReference( '/apex/StudentLogin');

 /* 'StudentLogin' is the name of the VF Page for login that is created below */

 }

 public PageReference loginUser()

 {

 return Site.login(username, password,'/500');

 /* 'NeedSupport'  is the Page to which we will be redirected after Login */

 }

 }
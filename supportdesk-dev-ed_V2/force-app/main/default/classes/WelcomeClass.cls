/*
REST Service URL: https://supportdesk-dev-ed.my.salesforce.com/services/apexrest/v1/Welcome/
*/

@RestResource(urlMapping='/v1/Welcome/*')
global with sharing class WelcomeClass {
	global Final static String WELCOME_MESSAGE = 'Welcome to Integration tutorials';
    
    @httpGet // there can be only one @httpGet method delaration. 
    global static String greetingMessage(){
        return WELCOME_MESSAGE;
    }
    /*
    @httpGet // there can be only one @httpGet method delaration [Error]: Only one method per type can be defined with: HttpGet
    global static String potgreetingMessage(){
    return WELCOME_MESSAGE;
    }*/
   
     @httpPost // there can be only one @httpPost method delaration. 
     global static String PostgreetingMessage(){
        return WELCOME_MESSAGE;
     }
    
     @httpPatch // there can be only one @httpPost method delaration. 
     global static String PatchgreetingMessage(){
        return WELCOME_MESSAGE;
     }
}
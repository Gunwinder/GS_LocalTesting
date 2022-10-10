/* APIs from https://home.openweathermap.org/api_keys */

public with sharing class testweatherController {
 // variables 
    public string city{get;set;}
    public string temp{get;set;}
    public string pressure{get;set;}
    public string humidity{get;set;}
    public string temp_min{get;set;}
    public string temp_max{get;set;}
    
    
    public testweatherController(ApexPages.StandardController stdController){
        Account account=(Account)stdController.getRecord();
        account=[SELECT Id,ShippingCity from ACCOUNT where Id =:account.id];
        
        STRING accountCity= account.ShippingCity;
        STRING apiKey='30f5acf76ac84b92acd8bc9b0f5b4070';
        STRING requestEndPoint = 'http://api.openweathermap.org/data/2.5/weather';
        // update the end point.
        requestEndPoint+='?q='+accountCity;
        requestEndPoint+='&units=metric';
        requestEndPoint+='&APPID='+apiKey;
        
        
        // new http request
        Http http= new Http();
        HttpRequest request=new HttpRequest();
        request.setEndpoint(requestEndPoint);
        request.setMethod('GET');
        
        HttpResponse response=http.send(request);
        // got a success message
        if(response.getStatusCode()==200){
            Map<string,Object> results=(Map<string,Object>)JSON.deserializeUntyped(response.getBody());
            city=string.valueOf(results.get('name'));
            Map<string,Object> mainresults=(Map<string,Object>)(results.get('main'));
            temp = string.valueOf(mainresults.get('temp'));
            pressure = string.valueOf(mainresults.get('pressure'));
            humidity = string.valueOf(mainresults.get('humidity'));
            temp_min = string.valueOf(mainresults.get('temp_min'));
            temp_max = string.valueOf(mainresults.get('temp_max'));
        }
        else{
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.severity.ERROR,'There was an error in reading the data from API');
            ApexPages.addMessage(myMsg);
        }
    }
}
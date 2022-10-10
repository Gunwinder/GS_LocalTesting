global class OpenCageGeocoderUtil {

    
    public static void forwardGeoCoding(id recordId){
        
        string endPoint = System.label.OpenCageEndpoint;
		string apiKey = System.Label.OpenCageKey;
        string errorMessage = '';
		
        //query account
        account accRecord = [select id,Name,ShippingStreet,Location__latitude__s, Location__longitude__s, ShippingState, ShippingPostalCode,ShippingCountry,ShippingCity FROM ACCOUNT WHERE id=:recordId];
        
        // Prepare query string to pass to API call
        string address = accRecord.ShippingStreet+','+ 
            			 accRecord.ShippingState +',' + 
            			 accRecord.ShippingPostalCode + ',' +
            			 accRecord.ShippingCountry + ',' + 
                         accRecord.ShippingCity; 
                          
        
        // based on API encoding is needed so we use standard apex function EncodingUtil.urlEncode
        string encodedString = EncodingUtil.urlEncode(address,'UTF-8');
        
        Http http 	 = new Http(); // create object to sent the info to external system. 
        httpRequest  httpReq  = new httpRequest();
        httpReq.setMethod('GET');  // define the type of method class should execute
        
        //https://api.opencagedata.com/geocode/v1/json?q=-22.6792%2C+14.5272&key=785928d18e814ce9a28f3c63200c94a1&pretty=1
		string finalEndPoint = endPoint+'q='+encodedString +'&key='+apiKey+'&pretty=1&limit=1';	
        httpReq.setEndpoint(finalEndPoint);
        httpReq.setHeader('content-type','application/json');
            httpResponse httpResp = new httpResponse();
		
		try{
		// send the request , httpReq is the object of the method.
		httpResp = http.send(httpReq);
        // check the status code returned. 
            if(httpResp.getStatusCode()==200){
                //get body
                String body = httpResp.getBody();
                system.debug(System.LoggingLevel.DEBUG, 'body' +body);
                // Call the class populated from Adminbooster.com to deserialize the results in the HTTP body
                OpenCageData OCData = (OpenCageData)System.JSON.deserialize(body, OpenCageData.class);
                list<opencagedata.results> results = OCData.results;
                // null check 
                if(results!=null && results.size()>0){
                    OpenCageData.results result = results.get(0);
                     accRecord.Location__latitude__s = result.geometry.lat;
                     accRecord.Location__longitude__s  = result.geometry.lng;
                     update accRecord;
                    system.debug(System.LoggingLevel.DEBUG, 'result' +result);
                }
            }else{
                errorMessage = 'Unexpected Error while communicating with API' + 'Status :' + httpResp.getStatus()+ 'and status code : '+httpResp.getStatuscode();
				system.debug(System.LoggingLevel.DEBUG, 'Exception Executed' +errorMessage);	
            }
            
        }catch(System.Exception e){
		if (String.valueof(e.getMessage()).startswith('unauthorized endpoint')){
		    errorMessage = 'Unauthorized endpoint : An administrator must goto Setup|Admister|Security Control|Remote Site and add an endpoint'+ endPoint ;
			
		}else{
		errorMessage = 'Unexpected Error while communicating with API' + 'Status :' + httpResp.getStatus()+ 'and status code : '+httpResp.getStatuscode();
		}
		system.debug(System.LoggingLevel.DEBUG, 'Exception Executed' +errorMessage);
		}
        
    }
}
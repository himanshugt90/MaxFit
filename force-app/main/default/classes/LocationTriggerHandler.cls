public class LocationTriggerHandler {
	
    @future(callout=true)
    public static void locationVerify(String recordId) {
        Location__c loc=[Select Id, Name, Verified__c, Street__c, City__c, Postal_Code__c, 
                           State__c From Location__c Where Id=: recordId];
      /*  MyUrl__c locUrl = MyUrl__c.getInstance(UserInfo.getOrganizationId());
        String baseUrl=locUrl.Url__c;
        baseUrl+='street='+loc.street__c+'&city='+loc.city__c+'&state='+loc.state__c+'&zipcode='+loc.Postal_Code__c+'&match=invalid';
        System.debug('Base url ='+baseUrl);*/
        String baseURL = 'https://us-street.api.smartystreets.com/street-address?auth-id=f1b15389-207a-9323-30a8-ad5698aad796&auth-token=yaFFr6St7vIhoan4VgEe';
        baseURL+= '&street='+EncodingUtil.urlEncode(loc.Street__c, 'UTF-8')
            	  +'&city='+EncodingUtil.urlEncode(loc.City__c, 'UTF-8')
            	  +'&state='+EncodingUtil.urlEncode(loc.State__c, 'UTF-8')
            	  +'&zipcode='+EncodingUtil.urlEncode(loc.Postal_Code__c, 'UTF-8')
            	  +'&match=invalid&candidates=10';
        httpRequest req=new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint(baseUrl);
        
        Http http=new Http();
        HttpResponse httpRes = new HttpResponse();
        try{
            httpRes=http.send(req);
                    System.debug('httpRes ='+httpRes.getStatusCode());

            if(httpRes.getStatusCode()==200 && httpRes.getStatus()=='OK'){
                String responseBody=httpRes.getBody();
                                    System.debug('httpRes ='+responseBody);

                if(!String.isBlank(responseBody) && responseBody.length() > 2){
                    loc.Verified__c = true;
                }else{
                    loc.Verified__c = false;
                }
                update loc;
            }else{
                TransactionHandler.doHandleExceptionWithError(httpRes.getBody(), 'LocationTriggerHandler');
            }
        }catch(Exception ex){
            TransactionHandler.doHandleException(ex, 'LocationTriggerHandler');
        }
        
    }
}
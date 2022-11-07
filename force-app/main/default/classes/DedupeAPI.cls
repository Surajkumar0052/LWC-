/**
* @File Name          : DedupeAPI.apxc
* @Author             : Umair Ahmad	
* @Created On         : 16 August 2022
*==============================================================================
* Ver         Date                     Author                 Modification
*==============================================================================
* 1.0       16 August 2022            Umair Ahmad             Initial Version
**/

public class DedupeAPI {
    
    /*
@Author : Umair Ahmad
@Description : This method is use to call Dedupe API.
*/
    public static string callDedupeAPI(String applicantId, String applicationId){
        
        system.debug('inside dedupeeee ');
        try{
            API_Handler__mdt EmandateAPI = [SELECT ID, isActive__c, HeaderParameters__c, Endpoint__c, Method__c, Mock_Response__c FROM API_Handler__mdt WHERE DeveloperName = 'Dedupe_API'];
            if(EmandateAPI.isActive__c){
                RequestHeader objRequestHeader = parseRequestHeader(EmandateAPI.HeaderParameters__c);
                system.debug('objRequestHeader '+objRequestHeader);
                
                Http http = new Http();
                HttpRequest request = new HttpRequest();
                request.setEndpoint(EmandateAPI.Endpoint__c);
                request.setMethod(EmandateAPI.Method__c); 
                request.setBody(generateRequestBody(applicationId));
                request.setHeader('Authorization', objRequestHeader.Authorization);
                request.setHeader('CORRELATION-ID',objRequestHeader.CORRELATIONID);
                request.setHeader('CLIENT-ID',objRequestHeader.CLIENTID);
                request.setHeader('CLIENT-SECRET',objRequestHeader.CLIENTSECRET);
                request.setHeader('Content-Type', objRequestHeader.ContentType);
                request.setHeader('token', objRequestHeader.TOKEN);
                request.setTimeout(120000);
                
                system.debug('request body '+request.getBody());
                
                
                HttpResponse objResponse = http.send(request); 
                
                system.debug('@@## response '+objResponse.getbody());
                
                if (objResponse != null && objResponse.getStatusCode() == 200) {
                    system.debug('@@## objDedupeResponse '+objResponse);
                }
            }
        }
        catch(System.CalloutException e) {
            system.debug('Main exception '+ e.getLineNumber() + ' - ' + e.getMessage());
            Error_Logger__c objErrorLog = new Error_Logger__c();
            objErrorLog.Exception_Message__c = e.getMessage();
            objErrorLog.Name = 'DedupeAPI';
            objErrorLog.Line_Number__c = string.valueof(e.getLineNumber());
            insert objErrorLog;
        }
        catch(Exception e){
            system.debug('Main exception '+ e.getLineNumber() + ' - ' + e.getMessage());
            Error_Logger__c objErrorLog = new Error_Logger__c();
            objErrorLog.Exception_Message__c = e.getMessage();
            objErrorLog.Name = 'DedupeAPI';
            objErrorLog.Line_Number__c = string.valueof(e.getLineNumber());
            insert objErrorLog;
        }
        return '';
    }
    
    
/*
@Author : Umair Ahmad
@Description : This method is use to create request body for Dedupe API.
*/
    private static String generateRequestBody(String applicationId){
        
        
        String requestJson = '';      
        
        requestJson += '{';
        requestJson += '"applicants": [';
        //for loop
        for(Loan_Applicant__C data : SELECT ID, Applicant_Type__c, Customer_Information__r.PersonBirthdate, Application__r.Sourcing_Branch__c,
            Permanent_Pincode__c FROM Loan_Applicant__C){

            requestJson += '{';
            requestJson += '"applicant": {';
            requestJson += ' "applicantType": "Individual",';
            requestJson += '"applicantId": "KGF123",';
            requestJson += '"dob": "24-06-1982",';
            requestJson += '"branch": "AD12345",';
            requestJson += '"pincode": "786543321120",';
            requestJson += '"kycIds": {';
            requestJson += '"pan": "AZKCF1234",';
            requestJson += '"passport": "KPKC2627876554",';
            requestJson += '"aadhaar": "19G02477825",';
            requestJson += '"voterId": "RRV1300466",';
            requestJson += '"drivingLicense": "tn07ksdjfksdjf"';
            requestJson += '}';
            requestJson += '}';
            requestJson += '}';
        }
   
        //yha tak for loop
        requestJson += ']';
        requestJson += '}';

        
        
        System.debug('@@## requestJson for Kotak Calculate API -> '+requestJson);
        return requestJson;
        
        List<Loan_Applicant__c> loanList = [SELECT ]
        
        
    }
    
    
    
    
    public class RequestHeader{
        public String Authorization;    //Basic YWRtaW46YWRtaW4=
        public String CORRELATIONID;    //123456789
        public String CLIENTID; //78g659ed2a0dfa2b
        public String CLIENTSECRET; //f56f68b65739bd8a
        public String ContentType;  //application/json
        public String TOKEN;   //M3gyTUpsa1I2QVdwanNsRXd5aWZSWmhQNG9sQmpYSlR1YmJJUnJQeWlTaz06YzcxMmNiMjgtZjIyNS00YjlmLTgwOGEtZWMxYTdjZjgwMGRkOjEyMTk5
    }
    public static RequestHeader parseRequestHeader(String json){
        return (RequestHeader) System.JSON.deserialize(json, RequestHeader.class);
    }
}
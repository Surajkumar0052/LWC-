/**
* @author            : Karan Singh Soni
* @group             : TechMatrix Consulting
* @description       : This class will invoke LMS create customer api which will create customer to external lms system.
* @created on        : 17-07-2022
* @last modified on  : 17-07-2022
* @last modified by  : Karan Singh Soni
**/
public without Sharing class FS_LMS_CreateCustomerAPI {
	public static Account objAct;
    //FS_LMS_CreateCustomerAPI.createCustomer('a0L0w000002e95wEAA');

    public static void createCustomer( String loanApptId ){

        List< Sobject > listSobject = new List< Sobject >();

        String payload = '{ "productProcessor": "EXTERNAL", "requestReferenceNumber": "339", "globalCustomer": { "associatedLoanAppId": "339", "hostCIFNumber": "", "contactInfo": { "preferredTelephoneType": "Mobile", "addressInfo": [ { "primaryAddress": true, "addressInfoPojo": { "accomodationTypeCode": "", "activeAddress": true, "addressLine1": "6/44 -1 namakkal,namakkal", "addressLine2": "null", "addressLine3": "", "addressLine4": "", "addressTypeCode": "ResidentialAddress", "area": "", "city": "007", "country": "IND", "district": "", "landMark": "", "monthsInCurrentCity": 0, "numberOfMonthsAtAddress": 0, "numberOfYearsAtAddress": 0, "phoneNumbers": [ { "countryCode": "IN", "isdCode": "+91", "stdCode": "", "telephoneExtension": "", "telephoneNumber": "8949595353", "telephoneTypeCode": "Mobile", "verified": true } ], "region": "IR", "residenceTypeCode": "Flat", "state": "MZ", "tehsil": "", "village": "", "yearsInCurrentCity": 0, "zipcode": "796001" } }, { "primaryAddress": false, "addressInfoPojo": { "accomodationTypeCode": "", "activeAddress": true, "addressLine1": "6/127 -1 cs puram,rasipuram", "addressLine2": "null", "addressLine3": "", "addressLine4": "", "addressTypeCode": "PermanentAddress", "area": "", "city": "010", "country": "IND", "district": "", "landMark": "", "monthsInCurrentCity": 0, "numberOfMonthsAtAddress": 0, "numberOfYearsAtAddress": 0, "phoneNumbers": [ { "countryCode": "IN", "isdCode": "+91", "stdCode": "", "telephoneExtension": "", "telephoneNumber": "8949595353", "telephoneTypeCode": "Mobile", "verified": true } ], "region": "IR", "residenceTypeCode": "Flat", "state": "MH", "tehsil": "", "village": "", "yearsInCurrentCity": 0, "zipcode": "444001" } }, { "primaryAddress": false, "addressInfoPojo": { "accomodationTypeCode": "", "activeAddress": true, "addressLine1": "6/120 -1 rs puram,rasipuram ", "addressLine2": "null", "addressLine3": "null", "addressLine4": "", "addressTypeCode": "OfficeAddress", "area": "", "city": "259", "country": "IND", "district": "", "landMark": "NTPC", "monthsInCurrentCity": 0, "numberOfMonthsAtAddress": 0, "numberOfYearsAtAddress": 0, "phoneNumbers": [ ], "region": "IR", "residenceTypeCode": "Flat", "state": "WB", "tehsil": "", "village": "", "yearsInCurrentCity": 0, "zipcode": "711101" } } ], "bankDetails": [ { "branchName": "KATAGERI", "accountTypeCode": "Salary A/c", "accountNumber": "61069126099", "bankName": "KARNATAKA VIKAS GRAMEENA BANK", "associatedLoanAppId": "", "clientId": null, "accountOpeningDate": null, "accountValidatedDate": null, "numberOfMonthsAccHeld": null, "remarks": null }, { "branchName": "UMRANALA", "accountTypeCode": "Saving", "accountNumber": "123456789010", "bankName": "State Bank of India", "associatedLoanAppId": "", "clientId": null, "accountOpeningDate": null, "accountValidatedDate": null, "numberOfMonthsAccHeld": null, "remarks": null } ], "telephoneInfo": [ { "primaryTelephone": true, "phoneNumbers": { "countryCode": "IN", "isdCode": "+91", "stdCode": "", "telephoneExtension": "", "telephoneNumber": "8949595353", "telephoneTypeCode": "Mobile", "verified": true } } ] }, "externalCustomerInfoFileNumber": "", "identificationInfo": [ { "expiryDate": "", "identificationNumber": "AKZPC9527F", "identificationTypeCode": "PAN", "issueDate": "", "issuingCountry": "" } ], "customerType": "individual", "personInfo": { "accountType": "", "aliasName": "", "constitutionCode": "Indiv", "customerCategoryCode": "SC", "customerSegmentCode": "NewCustomer", "dateOfBirth": "1980-08-12", "disability": "", "fatherName": "ABDUL HAMID", "firstName": "Virat", "fourthName": "", "fullName": "UZMA NAAZ SIDDIQUI", "genderCode": "FEMALE", "guardianName": "", "husbandName": "", "lastName": "Kohli", "maidenFirstName": "null", "maidenLastName": "null", "maidenMiddleName": "null", "maidenSalutation": "", "maritalStatusCode": "Married", "middleName": "", "motherName": "BADRUNISA SIDDIQUI", "mothersMaidenName": "", "nationality": "Indian", "placeOfBirth": "Indian", "religion": "", "residentType": "Resident Individual", "householdTypeCode": "Family", "salutationCode": "MR" }, "sourceSystem": "" } } ';

        try{


            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://uat-api.fsbl.in/api/1.0/ux/customer');
            request.setMethod('POST');
            request.setHeader('Authorization', 'Basic YWRtaW46YWRtaW4=');
            request.setHeader('CORRELATION-ID', 'HFGKDHN');
            request.setHeader('CLIENT-ID','78g659ed2a0dfa2b');
            request.setHeader('CLIENT-SECRET','f56f68b65739bd8a');
            request.setHeader('Content-Type', 'application/json');
            request.setHeader('Authorization', 'Basic ' +EncodingUtil.base64Encode(Blob.valueOf('admin:admin')));
            request.setBody(payload);
            request.setTimeout(120000);
            System.debug(payload);

            request.setBody(payload);
            HttpResponse response = http.send(request);
            System.debug('URL : ' + request.getEndpoint());
            System.debug('The status code returned : ' + response.getStatusCode() + ' ' + response.getStatus());
            System.debug(response.getBody());

            if (response != null && response.getStatusCode() == 201) {

                FS_LMS_CreateCustomerAPI objWrapResponse = parse(response.getbody());
                system.debug('@@## objRegResponse '+objWrapResponse);

                if( String.isNotBlank(objWrapResponse.customerInfoFileNumber )){
                    listSobject.add( new Loan_Applicant__c( Id = loanApptId, LMS_Customer_Info_File_Number__c = objWrapResponse.customerInfoFileNumber ));
                }


                API_Logger__c objAPILogger = new API_Logger__c();
                objAPILogger.Name = 'FS_LMS_CreateCustomerAPI';
                objAPILogger.API_Name__c = 'FS_LMS_CreateCustomerAPI';
                objAPILogger.Status__c = 'Success';
                objAPILogger.Request__c = request.getBody();
                objAPILogger.Response__c = response.getBody().length() > 130068 ? response.getBody().substring(0, 130068) : response.getBody();
                objAPILogger.EndPoint__c = request.getEndpoint();
                listSobject.add(objAPILogger);

                if(objWrapResponse != null){

                }

            }else{
                system.debug('API exception '+response);
                system.debug('API exception getStatusCode '+response.getStatusCode());
                Error_Logger__c objErrorLog = new Error_Logger__c();
                objErrorLog.Exception_Message__c = response.getbody();
                objErrorLog.Name = 'FS_LMS_CreateCustomerAPI';
                //listSobject.add( objErrorLog ) ;
            }
        }
        catch(System.CalloutException e) {
            system.debug('Main exception '+ e.getLineNumber() + ' - ' + e.getMessage());
            Error_Logger__c objErrorLog = new Error_Logger__c();
            objErrorLog.Exception_Message__c = e.getMessage();
            objErrorLog.Name = 'FS_LMS_CreateCustomerAPI';
            objErrorLog.Line_Number__c = string.valueof(e.getLineNumber());
            //listSobject.add( objErrorLog );
        }
        catch(Exception e){
            system.debug('Main exception '+ e.getLineNumber() + ' - ' + e.getMessage());
            Error_Logger__c objErrorLog = new Error_Logger__c();
            objErrorLog.Exception_Message__c = e.getMessage();
            objErrorLog.Name = 'FS_LMS_CreateCustomerAPI';
            objErrorLog.Line_Number__c = string.valueof(e.getLineNumber());
            //listSobject.add( objErrorLog );
        }

        if( !listSobject.isEmpty() ){
            upsert  listSobject;
        }
    }



    //--------------------------------------------------------------------------
    public String status;
    public String messageCode;
    public String messageDescription;
    public String requestReferenceNumber;
    public String customerInfoFileNumber;
    public String hostCustomerInfoFileNumber;
    public String associatedLoanAppId;
    public GlobalCustomerIdMapping globalCustomerIdMapping;

    public class CONTACT_DETAILS {
        public Object clientId;
        public String gcdId;
        public Boolean mappingChanged;
    }

    public class GlobalCustomerIdMapping {
        public List<CONTACT_DETAILS> CONTACT_DETAILS;
        public List<CONTACT_DETAILS> ADDRESS;
        public List<CONTACT_DETAILS> PHONE_NUMBER;
    }


    public static FS_LMS_CreateCustomerAPI parse(String json) {
        return (FS_LMS_CreateCustomerAPI) System.JSON.deserialize(json, FS_LMS_CreateCustomerAPI.class);
    }
    
    private static void fetchAccountDetails( String recordId ){
        FS_LMS_CreateCustomerAPI.objAct = [SELECT Id, PersonMobilePhone, Phone, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry,
                                           ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry,
                                           MS_Pincode__c, Landmark__c, Gender__c, Father_s_Name__c, Marital_Status__c, Mother_s_Name__c, 
                                           Number_of_children__c, Category__c, Salutation,
                                           //----------------------------------Application----------------------------------------------------------------------------------
                                           (SELECT Id, Name FROM Applications__r), (SELECT Id,Application__c,Application__r.Name FROM Loan_Applicants__r),
                                           //----------------------------------Bank_Details --------------------------------------------------------------------------------
                                           (SELECT Id, Name, Account_Opening_Date__c, Bank_Account_Holder_Name__c, Account_Number__c, Account_Type__c FROM Bank_Details__r)
                                           //----------------------------------LMS Details----------------------------------------------------------------------------------
                                           //(SELECT Id FROM LMS_Loan_Details__r)
                                           FROM Account WHERE Id =: recordId];
    }
    
    private static String generateRequestJson( String recordId ){
        String requestJson = '';
        try{

            //-------------------------------------------------------------( Map for MS pincode )-----------------------------------------------------------

            Map< String, List< MS_Pincode__c > > objMsPinCodeMap = new Map< String, List< MS_Pincode__c > >();

            for(MS_Pincode__c objMsPin : [ SELECT Id, Name, Pincode__c, City_Code__c, State_Code__c, StateName__c, Village_Locality_Name__c FROM MS_Pincode__c
                                          WHERE Pincode__c =: objAct.BillingPostalCode OR Pincode__c =: objAct.ShippingPostalCode 
                                          /* OR Pincode__c =: objAct.Pin_Code__c */ ]){
                                              if( objMsPin.Pincode__c == Null ){
                                                  continue;
                                              }
                                              if( !objMsPinCodeMap.containsKey( objMsPin.Pincode__c ) ){
                                                  objMsPinCodeMap.put( objMsPin.Pincode__c, new List< MS_Pincode__c >() );
                                              }
                                              objMsPinCodeMap.get( objMsPin.Pincode__c ).add( objMsPin );
                                          }
            System.debug('objMsPinCodeMap' + objMsPinCodeMap);
            
           // ---------------------------------------( Customer Category Code Metadata )------------------------------------------------------------------
            List< Finnone_CustomerCategoryCode__mdt > customerCategoryCodeMeta = [ SELECT Id, Code__c, Account_Category__c
                                                                                   FROM Finnone_CustomerCategoryCode__mdt
                                                                                   WHERE Account_Category__c =: objAct.Category__c ];
            
            requestJson = '{';
            requestJson += '"productProcessor":"' + 'External' +'"'+',';
            requestJson += '"requestReferenceNumber":"' + Integer.valueOf((objAct.Loan_Applicants__r[0].Application__r.Name).split('-')[1])+'"' + ','; 
			
			requestJson += '"globalCustomer":' + '{';
            requestJson += '"associatedLoanAppId":"' + Integer.valueOf((objAct.Loan_Applicants__r[0].Application__r.Name).split('-')[1]) + '"' + ','; 
            requestJson += '"hostCIFNumber":""' + ',';
            
            //--------------------------------------Contact Info-------------------------------------------------------------------------------
            
            requestJson += '"contactInfo":' + '{';
            requestJson += '"preferredTelephoneType":"Mobile"' + ',';
            
            //----------------------------------------------------( Address Info )-----------------------------------------------------------------------

            // ------------------------------------------------( Current Address details )--------------------------------------------------------

            requestJson += '"addressInfo":' + '[' + '{';
            requestJson += '"primaryAddress":"true"' + ',';
            requestJson += '"addressInfoPojo":' + '{';
            requestJson += '"accomodationTypeCode":""' + ',';                                 
            requestJson += '"activeAddress":true' + ',';
            requestJson += '"addressLine1":"' + objAct.BillingStreet + '"' + ',';
            requestJson += '"addressLine2":"' + objAct.BillingState + '"' + ',';
            requestJson += '"addressLine3":""' + ',';
            requestJson += '"addressLine4":""' + ',';
            requestJson += '"addressTypeCode":"ResidentialAddress",'; 
            requestJson += '"area":""' + ',';  
            
            String currentCityCode = '';
            if( objMsPinCodeMap.containsKey( objAct.BillingPostalCode ) ){
                for( MS_Pincode__c objMs : objMsPinCodeMap.get( objAct.BillingPostalCode ) ){
                    if( objMs.Village_Locality_Name__c == objAct.BillingCity ){
                      currentCityCode = String.valueOf(objMs.City_Code__c) ;
                    }
                }
            }
            
            requestJson += '"city":"' + currentCityCode + '"' + ',';      
            requestJson += '"country":"IND"' + ',';
            requestJson += '"district":""' + ',';
            requestJson += '"landMark":""' + ',';
            requestJson += '"monthsInCurrentCity":0' + ',';
            requestJson += '"numberOfMonthsAtAddress":0' + ',';
            requestJson += '"numberOfYearsAtAddress":0' + ',';
            
            requestJson += '"phoneNumbers":' + '[' + '{';
            requestJson += '"countryCode":"IN"' + ',';
            requestJson += '"isdCode":"+91"' + ',';
            requestJson += '"stdCode":""' + ',';
            requestJson += '"telephoneExtension":""' + ',';
            requestJson += '"telephoneNumber":"' + objAct.PersonMobilePhone + '"' + ',';
            requestJson += '"telephoneTypeCode":"Mobile"' + ',';
            requestJson += '"verified":true' + '}' + ']' + ',';

            requestJson += '"region":"IR"' + ',';
            requestJson += '"residenceTypeCode":"Flat"' + ',';
            
            String permanentStateCode = '';
            if( objMsPinCodeMap.containsKey( objAct.ShippingPostalCode ) ){
                for( MS_Pincode__c objMs : objMsPinCodeMap.get( objAct.ShippingPostalCode ) ){
                    if( objMs.Village_Locality_Name__c == objAct.ShippingCity  ){
                        permanentStateCode = String.valueOf(objMs.State_Code__c) ; // Add village Name and pincode in the query creteria then fetch the city code
                    }
                }
            }

            requestJson += '"state":"' + permanentStateCode+'"' + ',';              
            requestJson += '"tehsil":""' + ',';
            requestJson += '"village":""' + ',';
            requestJson += '"yearsInCurrentCity":0' + ',';
            requestJson += '"zipcode":"' + objAct.ShippingPostalCode + '"' + '}' + '}' + ',';
            
  // ------------------------------------------------------( Permanent Address details )---------------------------------------------------------------
        
            requestJson += '{';
            requestJson += '"primaryAddress":"false"' + ',';
            requestJson += '"addressInfoPojo":' + '{';
            requestJson += '"accomodationTypeCode":""' + ',';                                          
            requestJson += '"activeAddress":true' + ',';
            requestJson += '"addressLine1":"' + '"6/127 -1 cs puram,rasipuram"' + '"' + ',';
            requestJson += '"addressLine2":"' + '"null"' + '"' + ',';                                   
            requestJson += '"addressLine3":"' + '"' + ',';                                 
            requestJson += '"addressLine4":""' + ',';
            requestJson += '"addressTypeCode":"PermanentAddress"' + ',';                            
            requestJson += '"area":""' + ',';
            
              
            requestJson += '"city":"' + '010' +'"' + ',';        
            requestJson += '"country":"IND"' + ',';
            requestJson += '"district":""' + ',';
            requestJson += '"landMark":"' + '"' + ',';
            requestJson += '"monthsInCurrentCity":0' + ',';
            requestJson += '"numberOfMonthsAtAddress":0' + ',';
            requestJson += '"numberOfYearsAtAddress":0' + ',';
            
            requestJson += '"phoneNumbers":' + '[' + '{';
			requestJson += '"countryCode":"IN"' + ',';
			requestJson += '"isdCode":"+91"' + ',';
			requestJson += '"stdCode":""' + ',';
			requestJson += '"telephoneExtension":""' + ',';
			requestJson += '"telephoneNumber":"8949595353"' + ',';
			requestJson += '"telephoneTypeCode":"Mobile"' + ',';
			requestJson += '"verified":true' + '}' + ']' + ',';
            
            requestJson += '"region":"IR"' + ',';
            requestJson += '"residenceTypeCode":"Flat"' + ','; 
            

                
            requestJson += '"state":"MH"' + ',';                              
            requestJson += '"tehsil":""' + ',';
            requestJson += '"village":""' + ',';
            requestJson += '"yearsInCurrentCity":0' + ',';
            requestJson += '"zipcode":"444001"' + '}' + '},';
            
//------------------------------------------------------ Office Address Details---------------------------------------------------------------------------
            
            requestJson += '{';
            requestJson += '"primaryAddress":"false"' + ',';
            requestJson += '"addressInfoPojo":' + '{';
            requestJson += '"accomodationTypeCode":""' + ',';                                          
            requestJson += '"activeAddress":true' + ',';
            requestJson += '"addressLine1":"' + '"6/120 -1 rs puram,rasipuram"' + '"' + ',';
            requestJson += '"addressLine2":"' + '"null"' + '"' + ','; 
            requestJson += '"addressLine3":"' + '"null"' + '"' + ',';                                 
            requestJson += '"addressLine4":""' + ',';
            requestJson += '"addressTypeCode":"OfficeAddress"' + ',';                            
            requestJson += '"area":""' + ',';
            
            requestJson += '"city":"' + '259' +'"' + ',';        
            requestJson += '"country":"IND"' + ',';
            requestJson += '"district":""' + ',';
            requestJson += '"landMark":"NTPC"' + ',';
            requestJson += '"monthsInCurrentCity":0' + ',';
            requestJson += '"numberOfMonthsAtAddress":0' + ',';
            requestJson += '"numberOfYearsAtAddress":0' + ',';
            
            requestJson += '"phoneNumbers":' + '[' + '],';
            
            requestJson += '"region":"IR"' + ',';
            requestJson += '"residenceTypeCode":"Flat"' + ','; 
            

                
            requestJson += '"state":"WB"' + ',';                              
            requestJson += '"tehsil":""' + ',';
            requestJson += '"village":""' + ',';
            requestJson += '"yearsInCurrentCity":0' + ',';
            requestJson += '"zipcode":"711101"' + '}' + '},' + '],';
            
            
			requestJson += '"bankDetails":' + '[';
            
            if( objAct.Bank_Details__r.size() > 0 ){
                for( Bank_Detail__c objbankDetails : objAct.Bank_Details__r ){
                    
                    requestJson += '{';
                    requestJson += '"branchName":"KATAGERI"' + ',';
                    requestJson += '"accountTypeCode":"' + objbankDetails.Account_Type__c + '"' + ',';        
                    requestJson += '"accountNumber":"' + objbankDetails.Account_Number__c + '"' + ',';
                    requestJson += '"bankName":"KARNATAKA VIKAS GRAMEENA BANK"' + ',';
                    requestJson += '"associatedLoanAppId":""' + ',';
                    requestJson += '"clientId":null' + ',';
                    requestJson += '"accountOpeningDate":null' + ',';
                    requestJson += '"accountvalidatedDate":null' + ',';
                    requestJson += '"numberOfMonthsAccHeld":null' + ',';
                    requestJson += '"remarks":null' + '}' + ',';
                    
                    requestJson += '{';
                    requestJson += '"branchName":"UMRANALA"' + ',';
                    requestJson += '"accountTypeCode":"' + objbankDetails.Account_Type__c + '"' + ',';        
                    requestJson += '"accountNumber":"' + objbankDetails.Account_Number__c + '"' + ',';
                    requestJson += '"bankName":"State Bank of India"' + ',';
                    requestJson += '"associatedLoanAppId":""' + ',';
                    requestJson += '"clientId":null' + ',';
                    requestJson += '"accountOpeningDate":null' + ',';
                    requestJson += '"accountvalidatedDate":null' + ',';
                    requestJson += '"numberOfMonthsAccHeld":null' + ',';
                    requestJson += '"remarks":null' + '}' + ',';
                    
                    
                }
                
            }
            requestJson = requestJson.removeEnd(',');
			requestJson += +']' + ',';
            
//---------------------------------------------------------------( Telephone Info )---------------------------------------------------------------
            
            requestJson += '"telephoneInfo":' + '[';

            if( objAct.PersonMobilePhone != Null ){
                requestJson += '{';
                requestJson += '"primaryTelephone":"true"' + ',';
                requestJson += '"phoneNumbers":' + '{';
                requestJson += '"countryCode":"IN"' + ',';
                requestJson += '"isdCode":"+91"' + ',';
                requestJson += '"stdCode":""' + ',';
                requestJson += '"telephoneExtension":""' + ',';
                requestJson += '"telephoneNumber":"' + objAct.PersonMobilePhone+'"' + ',';
                requestJson += '"telephoneTypeCode":"Mobile"' + ',';
                requestJson += '"verified":true' + '}';
                requestJson += '}';
            }
      
            
            requestJson = requestJson.removeEnd(',');
            requestJson += ']';
            requestJson += '}' + ',';
            
//-----------------------------------------------------------( Identification Info )---------------------------------------------------------------

            requestJson += '"externalCustomerInfoFileNumber":""'+',';
            requestJson += '"identificationInfo":'+'[';

            
            requestJson += '{';
            requestJson += '"expiryDate":""'+',';
            requestJson += '"identificationNumber":"AKZPC9527F"' + ',';  
            requestJson += '"identificationTypeCode":"PAN"' + ',';
            requestJson += '"issueDate":""'+',';
            requestJson += '"issuingCountry":""'+'}';
            
            requestJson = requestJson.removeEnd(',');
            requestJson += ']'+',';
            
//-------------------------------------------------------------( Person Info )------------------------------------------------------------------------

            requestJson += '"customerType":"individual"'+',';
            requestJson += '"personInfo":'+'{';
            requestJson += '"accountType":""'+',';
            requestJson += '"aliasName":""'+',';
            requestJson += '"constitutionCode":"Indiv"'+',';

            if( customerCategoryCodeMeta.size() > 0 ){
               requestJson += '"customerCategoryCode":"'+customerCategoryCodeMeta[0].Code__c+'"'+',';               
            }else{
                requestJson += '"customerCategoryCode":""'+',';
            }

            requestJson += '"customerSegmentCode":"NewCustomer"' + ',';
            requestJson += '"dateOfBirth":"1980-08-12"' + ',';
            requestJson += '"disability":""' + ',';                                   
            requestJson += '"fatherName":"ABDUL HAMID"' + ',';
            requestJson += '"firstName":"Virat"'+',';
            requestJson += '"fourthName":""'+',';
            requestJson += '"fullName":"UZMA NAAZ SIDDIQUI"' + ',';
            requestJson += '"genderCode":"FEMALE"' + ',';

            requestJson += '"guardianName":""'+',';
            requestJson += '"husbandName":""'+',';
            requestJson += '"lastName":"Kohli"'+',';
            requestJson += '"maidenFirstName":"null"' + ',';
            requestJson += '"maidenLastName":"null"' + ',';
            requestJson += '"maidenMiddleName":"null"' + ',';
            requestJson += '"maidenSalutation":""'+',';

            if(objAct.Marital_Status__c == 'Unmarried' || objAct.Marital_Status__c == 'Others') {
                requestJson += '"maritalStatusCode":"Single"'+',';
            }
            else {
                requestJson += '"maritalStatusCode":"'+objAct.Marital_Status__c+'"'+',';            // '+objAct.Marital_Status__c+' , .
            }
            requestJson += '"middleName":""'+',';
            requestJson += '"motherName":"BADRUNISA SIDDIQUI"' + ',';
            requestJson += '"mothersMaidenName":""'+',';
            requestJson += '"nationality":"Indian"' + ',';
            requestJson += '"placeOfBirth":""'+',';
            requestJson += '"religion":""'+',';
            requestJson += '"residentType":"Resident Individual"' + ',';
            
            requestJson += '"householdTypeCode:"Family"' + ',';
            requestJson += '"salutationCode":"MR"' + '},';
            
            requestJson += '"sourceSystem":""'+'}'+'}';

			
			            
               
        }
        catch(Exception e){
            
        }
        return requestJson;
    
    }
}
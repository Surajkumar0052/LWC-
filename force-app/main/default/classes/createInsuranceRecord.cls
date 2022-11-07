public with sharing class createInsuranceRecord {
    @AuraEnabled
    public static Sobject createInsurance(Sobject objInsurance, String base64, String filename, String recId ){
        system.debug('objInsurance : '+objInsurance);
        try{
            system.debug('Sobject : ' + objInsurance);
            upsert objInsurance;
            //return insRecord;

            if( String.isNotEmpty(base64) && String.isNotEmpty(filename) ){

                ContentVersion objContntVrsn = new ContentVersion();
                objContntVrsn.VersionData = EncodingUtil.base64Decode(base64);
                objContntVrsn.FirstPublishLocationId = objInsurance.Id;
                objContntVrsn.Title = filename;
                objContntVrsn.PathOnClient = filename;
                objContntVrsn.PathOnClient = filename;

                insert objContntVrsn;
                system.debug( 'objContntVrsn id ' + objContntVrsn.Id );
            }

            else if(String.isEmpty(base64) && String.isEmpty(filename)){
                
            }
            
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }

        return objInsurance;
        
    }

    @AuraEnabled
    public static List<ContentVersion> getUploadedFileId(String parentId){
        //documentPrefix = documentPrefix + '%';
        return [SELECT Id, Title,ContentDocumentId FROM ContentVersion WHERE FirstPublishLocationId =:parentId ORDER BY CreatedDate DESC LIMIT 1];
        
        // SELECT ContentDocumentId, LinkedEntityId  FROM ContentDocumentLink where LinkedEntityId In (SELECT Id FROM Insurance_Details__c) 
    }


}
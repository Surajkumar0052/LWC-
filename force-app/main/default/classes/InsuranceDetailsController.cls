public with sharing class InsuranceDetailsController {
    @AuraEnabled(cacheable=true)
    public static List<Insurance_Details__c> getInsuranceDetailsRecords(){
        return [SELECT Insurance_Waiver__c, Insured_Person_Name__c, 
                                                     Insured_Person_Date_of_Birth__c, Nominee_Name__c, 
                                                     Nominee_Relationship_Type__c, 
                                                     Nominee_Relationship_with_Insured_Person__c, Nominee_KYC_ID_Type__c, 
                                                     Nominee_KYC_ID_No__c, 
                                                     Nominee_DOB_as_per_KYC__c, Insurance_Requirement__c, 
                                                     Insurance_Medical_Test_Result__c FROM Insurance_Details__c ];
    }

    // @AuraEnabled(cacheable=true)
    // public static List<ContentVersion> getDocumentId(String parentId, String documentPrefix){
    //     documentPrefix = documentPrefix + '%';
    //     return [SELECT Id, Title,ContentDocumentId FROM ContentVersion WHERE Title LIKE :documentPrefix ORDER BY CreatedDate DESC LIMIT 1];
    // }
}
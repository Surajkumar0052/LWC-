public with sharing class updateRecord {
    @AuraEnabled(cacheable=true)
    
    public static Contact getContact() {
        return [SELECT Id, FirstName, LastName FROM Contact LIMIT 1];
    }
}

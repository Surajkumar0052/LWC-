public with sharing class getContact {
    @AuraEnabled(cacheable=true)
    
    public static List<contact> fetchContact(String accountId) {
        return [SELECT Id, Name FROM contact WHERE AccountId =: accountId ];
    }
}

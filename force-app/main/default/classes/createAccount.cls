public with sharing class createAccount {
    @AuraEnabled
    public static Account getAccount(Account accObj){
        
        try{
            insert accObj;
            return accObj;
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }

    }
}

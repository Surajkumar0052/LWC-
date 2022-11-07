/*public with sharing class OpportunityController {
    @AuraEnabled(Cacheable=true)
    public static List<oppWrapper> getOppRecords(){
        
        Set<Id> recIds = new Set<Id>();
        
        List<oppWrapper> oppwrapperList = new List<oppWrapper>();
        
        List<Account> accList = [SELECT Id, Name, UserRecordAccess.HasReadAccess, (Select Name, Description, CloseDate, StageName, AccountId FROM Opportunities WHERE AccountId != Null),
                                 (SELECT Name , Email, Phone, AccountId FROM Contacts WHERE AccountId != Null ORDER BY CreatedDate desc) 
                                 FROM Account LIMIT 40 ];
        

        if(!accList.isEmpty()){
            for(Account acc : accList){
                recIds.add(acc.Id);
            }
        }
        
        List<UserRecordAccess> recAccessList = [SELECT RecordId, HasReadAccess, HasTransferAccess, MaxAccessLevel
                                                FROM UserRecordAccess
                                                WHERE UserId = : UserInfo.getUserId()
                                                AND RecordId IN : recIds];
        
        System.debug('AccList : ' + accList);
        System.debug('recAccessList : ' + recAccessList);
        
        if(!accList.isEmpty()){
            for(Account acc : accList){
                
                if(acc.Contacts.size() > 0 && acc.Opportunities.size() > 0 && acc.UserRecordAccess.HasReadAccess == true){
                    System.debug('UserRecordAccess.HasReadAccess : '+ acc.UserRecordAccess.HasReadAccess);
                    oppWrapper wrapperObj = new oppWrapper();
                    wrapperObj.accRec = acc;
                    wrapperObj.contactRec = acc.Contacts[0];
                    wrapperObj.oppRec = acc.Opportunities[0];
                    oppwrapperList.add(wrapperObj);
                }
                else if(acc.Contacts.size()>0 && acc.Opportunities.size()>0 && acc.UserRecordAccess.HasReadAccess == false){
                    oppWrapper wrapperObj = new oppWrapper();
                    Account a = new Account();
                    a.Name = acc.Name.substring(0,4) + '****';
                    wrapperObj.accRec = a;

                    wrapperObj.contactRec = acc.Contacts[0];
                    wrapperObj.oppRec = acc.Opportunities[0];
                    oppwrapperList.add(wrapperObj);
                }
            }
        }

        return oppwrapperList;
    }
    public class oppWrapper{
        @AuraEnabled
        public Opportunity oppRec{get;set;}
        @AuraEnabled
        public Contact contactRec{get;set;}
        @AuraEnabled
        public Account accRec{get;set;}
        
        
    }
}*/

 public with sharing class OpportunityController {
    @AuraEnabled(Cacheable=true)
    public static List<oppWrapper> getOppRecords(String searchKey){
                
        List<oppWrapper> oppwrapperList = new List<oppWrapper>();
        String key = '%' + searchKey + '%';

        List<Opportunity> oppList = [SELECT Id, StageName FROM Opportunity WHERE AccountId != Null];

        List<Account> acc = [SELECT Id, Name FROM Contact WHERE Id In: accIds];
        
        List<Account> accList = [SELECT Id, Name, UserRecordAccess.HasReadAccess, (Select Name, Description, CloseDate, StageName, AccountId FROM Opportunities WHERE AccountId != Null or StageName LIKE :key LIMIT 1),
                                 (SELECT Name , Email, Phone, AccountId, LastModifiedDate FROM Contacts WHERE AccountId != Null ORDER BY LastModifiedDate desc) 
                                 FROM Account WHERE Name LIKE :key];


        
        if(!accList.isEmpty()){
            for(Account acc : accList){
                
                if(acc.Contacts.size() > 0 && acc.Opportunities.size() > 0 && acc.UserRecordAccess.HasReadAccess == true){
                    System.debug('UserRecordAccess.HasReadAccess : '+ acc.UserRecordAccess.HasReadAccess);
                    oppWrapper wrapperObj = new oppWrapper();
                    wrapperObj.accRec = acc;
                    wrapperObj.contactRec = acc.Contacts[0];
                    wrapperObj.oppRec = acc.Opportunities[0];
                    oppwrapperList.add(wrapperObj);
                }
                
                else if(acc.Contacts.size()>0 && acc.Opportunities.size()>0 && acc.UserRecordAccess.HasReadAccess == false){
                    oppWrapper wrapperObj = new oppWrapper();
                    Account a = new Account();
                    a.Name = acc.Name.substring(0,4) + '****';
                    wrapperObj.accRec = a;
                    wrapperObj.contactRec = acc.Contacts[0];
                    wrapperObj.oppRec = acc.Opportunities[0];
                    oppwrapperList.add(wrapperObj);
                }
            }
        }

        return oppwrapperList;
    }
    public class oppWrapper{
        @AuraEnabled
        public Opportunity oppRec{get;set;}
        @AuraEnabled
        public Contact contactRec{get;set;}
        @AuraEnabled
        public Account accRec{get;set;}
        
        
    }
}
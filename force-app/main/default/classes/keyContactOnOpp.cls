// We have a field key contact on opportunity which is a lookup to opportunity. We have to check the budgets of all 
// contacts and amount of all opportunities associated with that account and set the contact which has budget just 
// greater than the amount on the particular opportunity not all the contacts which has budget greater than that.
public class keyContactOnOpp {
    public static void populateKeyContactOnOpps(List<Account> accList){
        Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>();
        List<Opportunity> oppList = new List<Opportunity>();
        
        for(Account acc : [SELECT Id, Name, (SELECT Budget__c FROM Contacts ORDER BY Budget__c Desc), 
                           (SELECT Amount, Key_Contact__c FROM Opportunities ORDER BY Amount) FROM Account
                           WHERE ID IN : accList]){
                               for(Contact con : acc.Contacts){
                                   for(Opportunity opp : acc.Opportunities){
                                       if(opp.Amount < con.Budget__c){
                                           opp.Key_Contact__c = con.Id;
                                       }
                                       oppList.add(opp);  
                                   }   
                               }    
                           }     
        oppMap.putAll(oppList);
        if(oppMap.size()>0){
            update oppMap.values();
        }
    }
}
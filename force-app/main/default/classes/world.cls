// We have to create two methods, one to get list of states in a country and other one to get capital of a country
// Create two more fields: City__c, Street__c
// getCity(String country, String state)
// getStreet(String country, String state, String city)

public class world {
    
    Map<String, Map<String, Map<String, List<String>>>> getStatesMap; 
    
    public world(){
        getStatesMap = new Map<String, Map<String, Map<String, List<String>>>>();
        
        for(World__c wcList : [SELECT State__c, Country__c, City__c, Street__c, Capital__c FROM World__c]){
            if(getStatesMap.containsKey(wcList.Country__c)){
                if(getStatesMap.get(wcList.Country__c).containsKey(wcList.State__c)){
                    if(getStatesMap.get(wcList.Country__c).get(wcList.State__c).containsKey(wcList.City__c)){
                        getStatesMap.get(wcList.Country__c).get(wcList.State__c).get(wcList.City__c).add(wcList.Street__c);
                        
                    }
                    else{
                        List<String> streetList = new List<String>();
                        streetList.add(wcList.Street__c);
                        getStatesMap.get(wcList.Country__c).get(wcList.State__c).put(wcList.City__c,streetList);
                        
                    }
                }
                else{
                    
                    List<String> streetList = new List<String>();
                    streetList.add(wcList.Street__c);
                    
                    Map<String, List<String>> cityMap = new Map<String, List<String>>();
                    cityMap.put(wcList.City__c, streetList);
                    
                    getStatesMap.get(wcList.Country__c).put(wcList.State__c,cityMap);
                }
                
            }
            
            
            
            else {
                
                List<String> streetList = new List<String>();
                streetList.add(wcList.Street__c);
                
                Map<String, List<String>> cityMap = new Map<String, List<String>>();
                cityMap.put(wcList.City__c,streetList);
                
                Map<String, Map<String, List<String>>> streetsMap = new Map<String, Map<String, List<String>>>();
                streetsMap.put(wcList.State__c,cityMap);
                
                getStatesMap.put(wcList.Country__c, streetsMap);
            } 
            
            
        }
    }
    
    public Set<String> getStates(String countryName){          
        return getStatesMap.get(countryName).keySet();
    }
    
    
    public Set<String> getCities(String countryName, String stateName){ 
        return getStatesMap.get(countryName).get(stateName).keySet();
    } 
    
    public List<String> getStreets(String countryName, String stateName, String cityName){          
        return getStatesMap.get(countryName).get(stateName).get(cityName);
    }
    
    
}
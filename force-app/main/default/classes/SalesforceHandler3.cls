public with sharing class SalesforceHandler3 {
   
    public static void cloneSalesforceId(List<SObject> newList){
     
        SObjectType type = newList.getSobjectType();
            List<SObject> modifiedList = new List<SObject>();
            for(SObject obj : newList){
                
                if(obj.get('Replication_Id__c')==null){
                    obj.put('Replication_Id__c',obj.Id);
                    modifiedList.add(obj);
                }
               
            } 
            UPDATE modifiedList;
        }
    
}
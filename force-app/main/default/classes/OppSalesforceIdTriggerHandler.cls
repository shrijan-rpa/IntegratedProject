public class OppSalesforceIdTriggerHandler implements TriggerAction.AfterInsert {
    
    public void afterInsert(List<Opportunity> newList)
    {
        /*    for (Opportunity obj:newList){
obj.Replication_Id__c = obj.id;
Update obj;
} */
        
        List<Opportunity> Opportunities = [SELECT Id FROM Opportunity WHERE Id IN :trigger.new];
        for(Opportunity a : Opportunities){
            a.Replication_Id__c = a.id;
        }
        UPDATE Opportunities;
    }
    
}
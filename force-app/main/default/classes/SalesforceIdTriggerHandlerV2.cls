/**
* @author Shrijan
* @date 2021
* @group Classes
* @description This class calls the salesforceIDHandler2 class passing trigger.new as parameter
*/

public with sharing class SalesforceIdTriggerHandlerV2 implements TriggerAction.AfterInsert {
   


    /** 
     *    @description	This method calls the static method of another class that copies the salesforce id to custom field.
     *    @param newList List of newly inserted SObjects
     *    @return	This method does not return any value.
     *    @example	Example code usage. This will be wrapped in tags to preserve whitespace
 
     */
 
     public void afterInsert(List<SObject> newList){
 
        /* Get the type of SObject  dynamically and store it in variable */
 
       // SObjectType type = newList.getSobjectType();
        SObjectType type = newList.getSobjectType();
      
        /* Store query in string variable that can be called in Database.Query
           escapeSingleQuotes adds the escape character (\) to all single quotation marks in a string that is passed in from a user. 
           The method ensures that all single quotation marks are treated as enclosing strings, instead of database commands.    
        */
    
       String query = String.escapeSingleQuotes('SELECT Id,Replication_Id__c FROM '+type+'  WHERE Id IN :newList');
 
        try {
            List<SObject> objs = Database.query(query);
 
            /* Loop through the list of SObjects returned by query */
 
            for(SObject obj : objs){
                
                /* If Replication__Id is empty copy salesforce Id to that field*/
                    if(obj.get('Replication_Id__c')==null){
                       obj.put('Replication_Id__c',obj.Id);
                        
                    }        
            }
 
            /* Bulk update the objects field that matches the criteria */
        
            UPDATE objs;
            
        }
        catch (Exception e) {
 
            System.debug('Exception handle step goes here for exception with message: '+e.getmessage());
            Logger.error('This is a test error');
            Logger.saveLog();
            throw e;
        }            
    }
 }
/**
* @author Shrijan
* @date 2021
* @group Classes
* @description This class has the static method that copies the salesforce Id to the custom field called Replication__Id.
*/

public with Sharing class SalesforceIdHandler2 {
  
    /** 
    *    @description	This method inputs salesforce id to the custom field if it's value is null.
    *    @param newList This parameter is of type list containing SObjects
    *    @return	    This method does not return anything.
    *    @example	Example code usage. This will be wrapped in tags to preserve whitespace
    *
    */
        public static void cloneSalesforceId(List<SObject> newList){
    
            /* Get the type of SObject  dynamically and store it in variable */

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
                throw e;
            }            
        }
    
    }
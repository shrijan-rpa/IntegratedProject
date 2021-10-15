/**
* @author Shrijan
* @date 2021
* @group Classes
* @description This class calls the salesforceIDHandler2 class passing trigger.new as parameter
*/

public with sharing class SalesforceIdTriggerHandler implements TriggerAction.AfterInsert{


   /** 
    *    @description	This method copies the salesforce id to custom field if the value of custom field is null. It also calls the static method from another class to instanciate 
    *        an sobject dynamically 
    *    @param newList List of newly inserted SObjects
    *    @return	This method does not return any value.
    *    @example	Example code usage. This will be wrapped in tags to preserve whitespace

    */

    public void afterInsert(List<SObject> newList){

       /* Get the type of SObject  dynamically and store it in variable */
       SObjectType type = newList.getSobjectType();


       /*Creating an empty list that will hold modified objects in future */ 
       List<SObject> modifiedList = new List<SObject>();

       try {
           /* Loop through the list of recently inserted objects */

           for(SObject obj : newList){
               
               /* If Replication__Id is empty copy salesforce Id to that field*/
                  if(obj.get('Replication_Id__c')==null){
                        
                        /* Creating a new instance of an object dynamically */

                         SObject newObj =  SObjectHandler.createNewSObject(String.ValueOf(type));

                         //System.debug ('Before id'+newObj.id);
                         
                         /* Assign same object id as the object that matches the criteria to the newly created instance */
                         newObj.id=obj.id;

                        //System.debug('After id'+newObj.id);         
                         
                        /* Input obj id to custom field */

                         newObj.put('Replication_Id__c',obj.Id);

                        /* Adding modified object to the empty list */

                         modifiedList.add(newObj);
                   }        
           }

           /* Bulk update the objects field that matches the criteria */
       
           UPDATE modifiedList;
           
       }
       catch (Exception e) {

           System.debug('Exception handle step goes here for exception with message: '+e.getmessage());
           Logger.error('This is an error:  '+e.getMessage()).addTag('Test Tag');
           Logger.saveLog();
           

           throw e;
       }       
   } 
}
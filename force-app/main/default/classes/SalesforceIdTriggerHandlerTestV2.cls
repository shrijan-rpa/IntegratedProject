@isTest
public with sharing class SalesforceIdTriggerHandlerTestV2 {
  
    @isTest
    static void afterInsert(){
        Account acc = new Account(Name='Test 1');

        insert acc;

        List<Account> newUser = new List<Account> ([select Id,Replication_Id__c from account where name ='Test 1']);
        //System.assertEquals(newUser[0].id,newUser[0].Replication_Id__c);
        for(Account accss:newUser){
            System.assertEquals(accss.id,accss.Replication_Id__c);
      
        }
    }

    @isTest
    static void afterInsertNegative(){
        Account acc = new Account(Name='Test 1');
        acc.Replication_Id__c='Testid';

        insert acc;

        List<Account> newUser = new List<Account> ([select Id,Replication_Id__c from account where name ='Test 1']);
        //System.assertEquals(newUser[0].id,newUser[0].Replication_Id__c);
        for(Account accss:newUser){
            System.assertNotEquals(accss.id,accss.Replication_Id__c);
      
        }
    }

}
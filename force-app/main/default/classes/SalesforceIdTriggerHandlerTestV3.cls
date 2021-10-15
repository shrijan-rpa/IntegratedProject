@isTest
public with sharing class SalesforceIdTriggerHandlerTestV3 {

    @TestSetup
    static void makeData(){
        List<Account> testAccounts = new List<Account>();    

        for (Integer i=0;i<50;i++){
            Account acc = new Account(Name='Test'+i);
            testAccounts.add(acc);
        }
        insert testAccounts;
    }
    
    @isTest
    static void afterInsert(){


        List<Account> newAccounts = new List<Account> ([select Id,Replication_Id__c from account where NAME = 'Test0']);
            
        System.assertEquals(newAccounts[0].id,newAccounts[0].Replication_Id__c);
        }
     
    }
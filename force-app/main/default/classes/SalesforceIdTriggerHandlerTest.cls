/**
* @author Shrijan
* @date 2021
* @group Classes
* @description This is the test class that test both positive and negative scenario for afterInsert trigger
*/


@isTest
public with sharing class SalesforceIdTriggerHandlerTest {


   /** 
    *    @description	This method tests the positive scenario for after insert. It creates data and checks the obj id and replication id for the record to match.
    *    @param  There are no parameters to this method.
    *    @return	This method does not return any value.
    *    @example	Example code usage. This will be wrapped in tags to preserve whitespace

    */

    @isTest
    static void afterInsertPositive(){

        /*Create a empty list of accounts for later use */
        List<Account> testAccounts = new List<Account>();    

        /*Loop thorugh 1 to 50 to create 50  test accounts*/ 
        for (Integer i=0;i<50;i++){
            Account acc = new Account(Name='Test'+i);
            testAccounts.add(acc);
        }

        /* Insert accounts to the database in bulk*/
        Test.startTest();
        insert testAccounts;
        Test.stopTest();

        /*Query accounts that were recently inserted and loop through them */
        List<Account> newAccounts = new List<Account> ([select Id,Replication_Id__c from account where Id in :testAccounts]);
        for(Account accRecent:newAccounts){
            
            /*Check if the account id and account's replication id field are the same */
            System.assertEquals(accRecent.id,accRecent.Replication_Id__c,'Replication id should be replaced with object id');
        }
     
    } 


   /** 
    *    @description	This method tests the negative scenario for after insert. It creates data with replication id and checks the obj id and replication id for the record to not match.
    *    @param  There are no parameters to this method.
    *    @return	This method does not return any value.
    *    @example	Example code usage. This will be wrapped in tags to preserve whitespace

    */

    @isTest
    static void afterInsertNegative(){

        /*Create a empty list of accounts for later use */
        List<Account> testAccounts = new List<Account>();    

        /*Loop thorugh 1 to 50 to create 50  test accounts*/ 
        for (Integer i=0;i<50;i++){
            Account acc = new Account(Name='Test'+i);
            acc.Replication_Id__c='testrecordid'+i;
            testAccounts.add(acc);
        }

        /* Insert accounts to the database in bulk*/
        Test.startTest();
        insert testAccounts;
        Test.stopTest();

        /*Query accounts that were recently inserted and loop through them */
        List<Account> newAccounts = new List<Account> ([select Id,Replication_Id__c from account where Id in :testAccounts]);
        for(Account accRecent:newAccounts){
            
            /*Check if the account id and account's replication id field are not the same */
            System.assertNotEquals(accRecent.id,accRecent.Replication_Id__c,'Replication Id should not be overwritten');
        }
     
    }
    
}
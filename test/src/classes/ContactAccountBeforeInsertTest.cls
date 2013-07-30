/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class ContactAccountBeforeInsertTest {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        System.debug('##>>> Start Testing ContactAccountBeforeInsertTest <<<');
         Profile p = [select id from profile where name = 'System Administrator'];
        
        User u = new User(alias = 'kevan', email='kevan1881@testorg.com', emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US', localesidkey='en_US', profileid = p.Id, timezonesidkey='America/Los_Angeles', username='kevan1881@testorg.com');
        System.runAs(u){
            system.debug('Current User: '+Userinfo.getUserName());
            system.debug('Current Profile: '+Userinfo.getProfileId());
            
            
            //start test debug
            test.startTest();
            
            /**
            * fields: Name, Parent, AccountId, BillingAddress
            */
            Account ac1 = new Account(Name = 'AC1', BillingStreet = 'AC1 BillingAddress');
            insert ac1;
            Account ac2 = new Account(Name = 'AC2',  BillingStreet = 'AC2 BillingAddress', Parentid = ac1.id);
            insert ac2;
            Account ac3 = new Account(Name = 'AC3',  BillingStreet = 'AC3 BillingAddress', Parentid = ac1.id);
            insert ac3;
            
            
            
            /**
            * fields: accountid, id, MailingStreet, ParentAccount
            */
            Contact c1 = new Contact(LastName='con1', Accountid = ac1.id, ParentAccount__c = false); 
            insert c1;
            Contact c2 = new Contact(LastName='con2', Accountid = ac2.id, ParentAccount__c = true);
            insert c2;
            
            //List<Contact> contactList = [select MailingStreet, id, LastName from Contact where LastName like 'c%' order by LastName];
            
            c1 = [select MailingStreet, id, LastName from Contact where Id = :c1.id];
            c2 = [select MailingStreet, id, LastName from Contact where Id = :c2.id];
            
            System.debug('##>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> CONTACT 1 <<< ' + c1.MailingStreet);
            System.debug('##>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> CONTACT 2 <<< ' + c2.MailingStreet);
             
            
            System.assertEquals(c1.MailingStreet, ac1.BillingStreet);
            System.assertEquals(c2.MailingStreet, ac1.BillingStreet);
            
            /*
            c1.accountId = ac3.id;
            c1.ParentAccount__c = true;
            */
            //end test debug
            test.stopTest();
        }//end runas user
        System.debug('##>>> End Testing ContactAccountBeforeInsertTest <<<');
    }//end method testing
}
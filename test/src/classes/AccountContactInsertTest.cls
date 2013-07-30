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
private class AccountContactInsertTest {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        Profile p = [select id from profile where name = 'System Administrator'];
        
        User u = new User(alias = 'kevan', email='kevan1881@testorg.com', emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US', localesidkey='en_US', profileid = p.Id, timezonesidkey='America/Los_Angeles', username='kevan1881@testorg.com');
        System.runAs(u){
        	system.debug('Current User: '+Userinfo.getUserName());
        	system.debug('Current Profile: '+Userinfo.getProfileId());
	        
	        
	        list<Account> accList = new list <Account>();
	        
	        accList.add(new Account(Name = 'AC1'));
	        accList.add(new Account(Name = 'AC2'));
	        accList.add(new Account(Name = 'AC3')); 
	        accList.add(new Account(Name = 'Bad'));
	        
	        test.startTest();
	        insert accList; 
	        test.stopTest(); 
        	
        	list <Contact> contactList = new list <Contact>([select accountid, Lastname from contact where accountid IN :accList order by accountid]);
        	//for(Contact c : contactList){
        		//system.debug('Contact: '+c.lastname);
        	for (integer i = 0; i < accList.size(); i++){
        		system.assertEquals(accList[i].name, contactList[i].lastname);
        		system.assertEquals(accList[i].id, contactList[i].accountid);
        		
        	}	
        		
        		//system.assertEquals('AC7', contactList[1].lastname);
        		//system.assertEquals(accList[1].id, contactList[1].accountid);
        	//}
        	
        }
    }
}
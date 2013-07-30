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
private class JobApplicationReviewUpdateTest {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        Profile p = [select id from profile where name = 'System Administrator'];
        
        User u = new User(alias = 'kevan', email='kevan1881@testorg.com', emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US', localesidkey='en_US', profileid = p.Id, timezonesidkey='America/Los_Angeles', username='kevan1881@testorg.com');
        System.runAs(u){
        	system.debug('Current User: '+Userinfo.getUserName());
        	system.debug('Current Profile: '+Userinfo.getProfileId());
	    
		    Candidate__c cand = new Candidate__c(First_Name__c = 'firsttest', 
		    						Last_Name__c = 'lasttest', 
		    						Email__c = 'test1@test.com',
		    						Currently_Employed__c = true,
		    						Education__c = 'BSC',
		    						Phone__c = '4587754'
		    						);
		    
		    test.startTest();
		    insert cand;
		    
		    system.debug('Candidate Id: ' + cand.id);
		    
		    Job_Application__c job = new Job_Application__c(Candidate__c = cand.id, 
		    												Position__c = 'a00b0000006lGa6'
		    												);
		    insert job;
		    
		    Review__c rev = new Review__c(	Rating__c = 5, 
		    								Job_Application__c = job.id
		    							 ); 
		    insert rev;
		    
		    
		    Candidate__c cand2 = new Candidate__c(First_Name__c = 'firsttest2', 
		    						Last_Name__c = 'lasttest2', 
		    						Email__c = 'test2@test.com',
		    						Currently_Employed__c = true,
		    						Education__c = 'BSC2',
		    						Phone__c = '12345678'
		    						);
		    insert cand2;
		    
		    
		    job.Candidate__c = cand2.id;
		    update job;
		    
		    
		    list<Review__c> rev1 = [Select PreviousCandidate__c, 
					    				Job_Application__c, 
					    				IsCandidateCurrentlyEmployed__c, 
					    				Id, 
					    				CandidatePhone__c, 
					    				CandidateEducation__c 
				    				From Review__c	
				    				where id = :rev.id
				    				];
		    
		    system.debug('##>>> review list  <<< '+rev1);	
		    				
		   	test.stopTest();
		   	
		    System.assertEquals(cand2.Phone__c, rev1[0].CandidatePhone__c);
		    System.assert(cand2.Currently_Employed__c, rev1[0].IsCandidateCurrentlyEmployed__c);
		    System.assertEquals(cand2.Education__c, rev1[0].CandidateEducation__c);    
		    System.assertEquals(cand.First_Name__c+' '+cand.Last_Name__c, rev1[0].PreviousCandidate__c);
        }
        
        
        
    }
}
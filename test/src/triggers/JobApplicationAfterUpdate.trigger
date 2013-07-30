trigger JobApplicationAfterUpdate on Job_Application__c (after update) {
	
	System.debug('## >>> Start JobBeforeUpdate <<<');
	if (trigger.new.size() > 0){
		map<id, Job_Application__c> mapJobAppNew = new map <id, Job_Application__c>();
		map<id, Job_Application__c> mapJobAppOld = new map <id, Job_Application__c>();
		
		for (integer i = 0; i < trigger.new.size(); i++){
			//map id= job application id , value=obj job application
			if (trigger.new[i].Candidate__c != trigger.old[i].Candidate__c && trigger.new[i].Candidate__c != NULL){
				mapJobAppNew.put(trigger.new[i].id, trigger.new[i]);
				mapJobAppOld.put(trigger.old[i].id, trigger.old[i]);
			}
		}
		JobApplicationReviewUpdate.updateReview(mapJobAppOld, mapJobAppNew);
		
	}
	
	/*
	
	//get all job application id from update
	if (trigger.new.size() > 0){
		map <Id, Job_Application__c> mapJobApp = new map <Id, Job_Application__c>() ;
		map <Id, Job_Application__c> mapJobAppOld = new map <Id, Job_Application__c>() ;
		
		for(integer i = 0; i < trigger.new.size(); i++){
			if (trigger.new[i] != trigger.old[i]){
				mapJobApp.put(trigger.old[i].Id, trigger.new[i]);
				mapJobAppOld.put(trigger.old[i].Id, trigger.old[i]);
			}	
		}
		System.debug('##>>> Start Trigger JobApplicationReviewAfterUpdate <<<');
		System.debug('##>>> MapJobApp <<<'+mapJobApp.values()+' key: ' + +mapJobApp.keySet());
		//JobApplicationReviewUpdate.updateReview(mapJobApp);
		JobApplicationReviewUpdate.updateReview(mapJobApp, mapJobAppOld);
		System.debug('##>>> End Trigger JobApplicationReviewAfterUpdate <<<');							 				
		
		 
	}//end if trigger.new contains elements
	
	//
	*/
}
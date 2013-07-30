public with sharing class JobApplicationReviewUpdate {

	public static void updateReview(map<id, Job_Application__c> mapJobAppOld, map<id, Job_Application__c> mapJobAppNew){
		if (mapJobAppNew.size() > 0){
			list<id> candId = new list<id>();
			//get all candidate id
			for (Job_Application__c cid: mapJobAppNew.values()){
				if (cid.candidate__c != NULL){
					candId.add(cid.candidate__c);
				}
			}
			for (Job_Application__c cid: mapJobAppOld.values()){
				if (cid.candidate__c != NULL){
					candId.add(cid.candidate__c);
				}
			}
			
			//get all candidates
			map <Id, Candidate__c> candidateMap = new map <Id, Candidate__c>([	Select  Phone__c, 
																		Last_Name__c, 
																		Id, First_Name__c, 
																		Currently_Employed__c,
																		Education__c 
																From Candidate__c
																where Id In :candId 
															]);
			
			System.debug('##>>> Reviewlist <<<');													
			map<Id, Review__c> reviewMap = new map<Id, Review__c>([	Select  PreviousCandidate__c, 
																	Job_Application__c, 
																	IsCandidateCurrentlyEmployed__c, 
																	Id, 
																	CandidatePhone__c, 
																	CandidateEducation__c 
															From Review__c
															where Job_Application__c IN :mapJobAppNew.keySet()
													]);
			System.debug('##>>> Assigning fields to update <<<');
			list<Review__c> newReviewList = new list<Review__c>();
			if (reviewMap.size() > 0){
				for(Review__c r:reviewMap.values()){
					Job_Application__c jobOld = mapJobAppOld.get(r.Job_Application__c);
					Job_Application__c jobNew = mapJobAppNew.get(r.Job_Application__c);
					id previousCandidate = jobOld.candidate__c;
					id newCandidate = jobNew.candidate__c;
					
					String preCandName = candidateMap.get(previousCandidate).First_Name__c + ' ' + candidateMap.get(previousCandidate).Last_Name__c;
					
					Review__c rev = new Review__c();
					rev.id = r.id;
					rev.IsCandidateCurrentlyEmployed__c = candidateMap.get(jobNew.candidate__c).Currently_Employed__c;
					rev.CandidateEducation__c = candidateMap.get(jobNew.candidate__c).Education__c;
					rev.CandidatePhone__c = candidateMap.get(jobNew.candidate__c).Phone__c;
					rev.PreviousCandidate__c = preCandName;
					
					newReviewList.add(rev);
					
				}
			}
			System.debug('##>>> Updating Review <<<');
			if(newReviewList.size() > 0){
				update newReviewList;
				System.debug('##>>> Update Successfull <<<');
			}
			
		}
	}
	
	/*
	//updatereview(map(jobid, candid))
	public static void updateReview(map <Id, Job_Application__c> mapJobAppOld, map <Id, Job_Application__c> mapJobApp){
		
		if(mapJobApp.size() > 0){
			
		list <id> jobApplication = new list <id>();
		for(Job_Application__c j : mapJobApp.values()){
			jobApplication.add(j.id);
		}
		 
		map <Id, Candidate__c> candidateList = new map <Id, Candidate__c>([	Select  Phone__c, 
																		Last_Name__c, 
																		Id, First_Name__c, 
																		Currently_Employed__c,
																		Education__c 
																From Candidate__c
																where Id In :jobApplication 
															]);
		System.debug('##>>> Candidatelist <<<'+candidateList.values());													
		map<Id, Review__c> reviewList = new map<Id, Review__c>([	Select  PreviousCandidate__c, 
																	Job_Application__c, 
																	IsCandidateCurrentlyEmployed__c, 
																	Id, 
																	CandidatePhone__c, 
																	CandidateEducation__c 
															From Review__c
															where Job_Application__c IN :mapJobApp.keySet()
													]);
		System.debug('##>>> review list <<<'+reviewList.values());											
		list<Review__c> newReviewList = new list<Review__c>();
		
		if (reviewList.size() > 0){
			for(Review__c r : reviewList.values()){
				Job_Application__c candidateId = mapJobApp.get(r.Job_Application__c);
				System.debug('##>>> ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; <<<');
				Candidate__c candi = candidateList.get(candidateId.Candidate__c);
				
				if (candi != NULL){
					r.IsCandidateCurrentlyEmployed__c = candi.Currently_Employed__c;
					r.CandidateEducation__c = candi.Education__c;
					r.CandidatePhone__c = candi.Phone__c;
					//r.PreviousCandidate__c = r.Candidate__c;
					Id previousCandidate = mapJobAppOld.get(r.Job_Application__c).Candidate__c;
					String canName = candidateList.get(previousCandidate).First_name__c+' '+candidateList.get(previousCandidate).Last_name__c;
					System.debug('##>>> Previous candidate <<< '+ canName);
					r.PreviousCandidate__c= canName;
					newReviewList.add(r);
				}
			}
			update newReviewList;
		}
		
		System.debug('##>>> newreviewlist <<<'+newReviewList);
		}//end if mapJobApp size
	}
	*/
}
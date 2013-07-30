trigger AccountBeforeInsert on Account (before insert) {
	
	List<Account> accList = new List<Account>();
	/*
	for (Account acd: [select id, name from account]){
		if (acd.name == 'Bad'){
			accList.add(acd);
		}
	}
	delete accList;
	*/
	
	for (Account acc: trigger.new){
		if (acc.Name == 'Bad'){
			acc.Description = 'Invalid Description';
		}
	}
	
	
}
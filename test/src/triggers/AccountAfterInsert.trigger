trigger AccountAfterInsert on Account (after insert){
	/*Contact c = new Contact();
	c.AccountId = trigger.new[0].Id;
	c.LastName = trigger.new[0].Name;
	
	insert c;*/
	//AccountContactInsert.InsertContact(trigger.new[0]);
	/*
	for (Account acc: trigger.new){
		AccountContactInsert.InsertContact(acc);
	}
	*/
	////good 
	/*
	List<Account> accList = new List<Account>();
	for (Account acc : trigger.new) {
		if (acc.Name != NULL){
			accList.add(acc);
		}
	}
	
	if (accList.size() > 0){
		AccountContactInsert.InsertContact(accList);
	}
	*/
	
}
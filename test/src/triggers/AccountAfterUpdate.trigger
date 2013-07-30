trigger AccountAfterUpdate on Account (after update) {
	id id =  trigger.new[0].Id;
	List<Contact> conlist = new List<Contact>();
	conlist = [Select Id, Account_Number__c From Contact where accountid = :id];
	
	for (Contact c: conlist){
		c.Account_Number__c = trigger.new[0].AccountNumber;
	}
	update conlist;
	
}
trigger ContactAfterInsert on Contact (after insert) {
	/*
	list<Contact> listContacts = new list<Contact>();
	set<Id> setAccountIds = new set<Id>();
	
	for(integer i = 0; i < trigger.new.size(); i++){
		if(trigger.new[i].Phone != null) {
			listContacts.add(trigger.new[i]);
			if(trigger.new[i].AccountId != null){
				setAccountIds.add(trigger.new[i].AccountId);
			}
		}
	}
	
	
	if (setAccountIds.size() > 0){
		AccountPhoneUpdate.updateAccountPhone(listContacts, setAccountIds);
	}
	*/
	
	/*System.debug('##>>> Start Trigger ContactAfterInsert <<<');
	List<Contact> conList = new List<Contact>();
	List<Account> accList = new List<Account>();
	for (Contact con: trigger.new){
		if (con.Phone != NULL){
			System.debug('##>>> Inside Phone exist <<<');
			if (con.accountid != NULL){
				System.debug('##>>> inside accountID <<<');
				String accID = con.accountID;
				Account acc = [select id, AccountNumber, Phone from Account where id = :accID];
				if (acc.phone == NULL){
					System.debug('##>>> inside account phone <<<');
					acc.phone = con.phone;
					accList.add(acc);
				}
			}
			
		}//end if phone exist
		
	}//end for
	update accList;
	System.debug('##>>> update completed <<<');
	System.debug('##>>> End Trigger ContactAfterInsert <<<');
	*/
}
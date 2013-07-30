trigger ContactAccountBeforeInsert on Contact (before insert, before update) {
	System.debug('##>>> Start Trigger ContactAccountBeforeInsert <<<');
 	if (trigger.new.size() != NULL){
 		list<Contact> contactList = new list<Contact>();
 		for(Contact c : trigger.new){
 			contactList.add(c);
 		}	
 		if (contactList.size() > 0){
 			ContactAccountBeforeInsert.contactInsert(contactList);
 		}
 	}
 	System.debug('##>>> End Trigger ContactAccountBeforeInsert <<<');
}
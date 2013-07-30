public with sharing class ContactAccountBeforeInsert {
	public static void contactInsert(list<Contact> contactList){
		
		map<id, Account> acctMap = new map<id, Account>();
		for(Contact c: contactList){
			Account ac = new Account();
			ac.Id = c.AccountId;
			acctMap.put(c.accountId, ac);
		}
		map<id, Account> addAccMap = new map<id, Account>([Select Parent.BillingStreet,  BillingStreet From Account where id IN :acctMap.keySet()]);		
		for(Contact c: contactList){
			if (c.Accountid != NULL){
				if (c.ParentAccount__c == false){
					c.MailingStreet = addAccMap.get(c.accountid).BillingStreet;
				}
				else{
					c.MailingStreet = addAccMap.get(c.accountid).Parent.BillingStreet;
				}
			}
		}
		
	}
}
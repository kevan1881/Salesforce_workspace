public with sharing class AccountPhoneUpdate {
	/*public static void updateAccountPhone(list <Contact> listContacts, set<Id> setAccountIds){
		map<Id, Account> mapAccounts = new map <Id, Account>();
		list<Account> listAccounts = [SELECT  id, phone from Account where id IN :setAccountIds];
		
		for (Account acc : listAccounts) {
			mapAccounts.put(acc.id, acc);
		}
		
		for (Contact con : listContacts){
			if (mapAccounts.keySet().contains(con.AccountId)){
				if (mapAccounts.get(con.AccountId).phone == NULL){
					mapAccounts.get(con.accountid).Phone = con.Phone;
				}
			}
		}
		
		update mapAccounts.values();
		
	}*/

 public static void updateAccountPhone(list<Contact> listContacts, set<Id> setAccountId)
 {
  map<Id, Account> mapAccounts = new map<Id, Account>();
  list <Account> listAccountsToUpdate = new list<Account>();
  list <Account> listAccounts = [SELECT Id, Phone FROM Account WHERE Id IN :setAccountId];
  
  for (Account acc : listAccounts)
  {
   mapAccounts.put(acc.Id, acc);
  }
  
  /*
   map<Id, Account> mapAccounts = new map<Id, Account>()[SELECT Id, Phone FROM Account WHERE Id IN :setAccountId];
  */
  
  for(Contact con: listContacts)
  {
   //check if Contact.AccountId is present in MapAccounts
   //map.keySet() returns a set of all keys
   if (mapAccounts.keyset().contains(con.AccountId))
   {
    if (mapAccounts.get(con.AccountId).Phone == null)
    {
     mapAccounts.get(con.AccountId).Phone = con.Phone;
     listAccountsToUpdate.add(mapAccounts.get(con.AccountId));
    }//end if
   }//end if
  }//end for 
  
  if(listAccountsToUpdate.size() > 0)
  {
   update listAccountsToUpdate;
  }
 }//end 
}
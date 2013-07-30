public with sharing class ContactAccountInsertController {
	
	public Account acc{get;set;}
	public Contact con{get;set;}
	
	public ContactAccountInsertController(){
		acc = new Account();
		con = new Contact();
	}
	
	  public PageReference save() 
    {
       try 
       {
       		list<Account> checkAcc = [Select id, Name from Account where name = :acc.Name];
       		if (checkAcc.size() > 0){
       			ApexPages.message myMsg = new ApexPages.message(ApexPages.Severity.WARNING, 'Cannot have duplicates');
       			ApexPages.addMessage(myMsg);
       		} else {
	           insert(acc);
	           con.AccountId = acc.Id;
	           con.MailingStreet = acc.BillingStreet;
	           insert(con);
       		}
       } 
       catch(System.DMLException e) 
       {
           ApexPages.addMessages(e);
           return null;
       }
       //  After Save, navigate to the default view page:  
       return (new ApexPages.StandardController(acc)).view();
   }
	
	
	
	
}
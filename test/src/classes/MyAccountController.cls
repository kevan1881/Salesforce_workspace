public class MyAccountController {
    Account account;

    public PageReference save() {
		ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.WARNING,'Nothing has been saved'));
		return null;
    }

    public String getName() { 
        return 'MyAccountController';
    }

    public Account getAccount() {
        if(account == null)
        account = [select id, name, numberofemployees, numberoflocations__c from Account
        where id = :ApexPages.currentPage().getParameters().get('id')];
        return account;
    }
}
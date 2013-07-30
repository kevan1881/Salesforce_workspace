public class MyControllerExtension {

    private final Account acct;
    public String greeting{get;set;}
    // The extension constructor initializes the private member  
    
    // variable acct by using the getRecord method from the standard  
    
    // controller.  
    
    public MyControllerExtension(ApexPages.StandardController stdController) {
        this.acct = (Account)stdController.getRecord();
		greeting = 'Hello ' + acct.name + ' (' + acct.id + ')';
    }
}
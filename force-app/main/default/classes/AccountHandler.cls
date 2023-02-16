public class AccountHandler {
    
    public static Account insertNewAccount(String person) {
        Account account = new Account(Name=person);
        
        try{            
        	insert account;        
        	System.debug('Account ' + account);
        } catch (DmlException e) {
            System.debug('A DML exception has occurred: ' +
                e.getMessage());
            return null;
        }  
        return account;
    }
}
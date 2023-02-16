public class AccountProcessor {
    @future
    public static void countContacts(List<Id> accountIds) {
        //List to get the number of contacts
        List<Account> accountsToUpdate = new List<Account>();

        //List of contacts to iterate
        List<Account> accounts = [Select Id, Name, (Select Id from Contacts) from Account Where Id IN :accountIds];

        //Iterate through the accounts
        for( Account account : accounts ) {
            List<Contact> contacts = account.Contacts;
            account.Number_Of_Contacts__c = contacts.size();
            accountsToUpdate.add(account);
        }
        //Update the accounts count
        update accountsToUpdate;
    }
}
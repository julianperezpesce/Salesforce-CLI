public class AddPrimaryContact implements Queueable {

    private Contact contact;
    private String state;
    public AddPrimaryContact(Contact contact, String state) {
        this.contact = contact;
        this.state = state;
    }
    public void execute(QueueableContext context) {
        // Query limited to 200 records
        List<Account> accounts = [Select Id, Name, (Select FirstName, LastName, Id from Contacts) from Account where BillingState = :state Limit 200];

        List<Contact> primaryContacts = new List<Contact>();

        for(Account account : accounts) {
            Contact c = contact.clone();
            c.AccountId = account.Id;
            primaryContacts.add(c);
        }

        if(primaryContacts.size() > 0) {
            insert(primaryContacts);
        }
    }
}
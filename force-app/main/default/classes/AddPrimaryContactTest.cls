@isTest
public class AddPrimaryContactTest {    
    static testmethod void testQueueable() {      
        List<Account> accounts = new List<Account>();
        // add a parent account
        // accounts.add(new Account(name='Parent'));
        // add 100 child accounts
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(name='Test Account'+i, BillingState='CA'));
        }
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(name='Test Account'+i, BillingState='NY'));
        }
        insert accounts;

        Contact contact = new Contact(FirstName='Test', LastName='Contact');
        insert contact;    
     
        // Create our Queueable instance
        AddPrimaryContact updater = new AddPrimaryContact(contact, 'CA');
        // startTest/stopTest block to force async processes to run
        Test.startTest();
        System.enqueueJob(updater);
        Test.stopTest();
        // Validate the job ran. Check if record have correct parentId now
        System.assertEquals(50, [select count() from Contact where accountId in (Select Id from Account where BillingState='CA')]);
    }
}
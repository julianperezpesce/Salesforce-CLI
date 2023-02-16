@isTest
private class NewContactForNewAccountTest {
    @isTest
    static void accountTrigger_afterInsertTest() {
        Account anAccount = new Account(Name = 'TestAccount 1', Type = 'Prospect');

        //Perform Test
        Test.startTest();
            insert anAccount;
        Test.stopTest();

        //Fetch the account that we have inserted 
        Account insertedAccount = [SELECT Id, FirstName, Type FROM Account LIMIT 1];

        List<Contact> insertedContacts = [SELECT Id, Account.Name from Contact];
        System.assertEquals(1, insertedContacts.size(), 'Only 1 Contact should present');
        System.assertEquals(insertedAccount.Name, insertedContacts[0].Account.Name, 'Account Name does not match');
    }
}
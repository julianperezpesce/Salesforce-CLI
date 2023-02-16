@isTest
private class UpdateContactsForTheNewAccountOwnerTest {
    @TestSetup
    static void testData(){
        //Create instance of a standard user
        Profile standarProfile = [SELECT Id, Name from Profile WHERE Name='Standard User'];
        User standardUser = new User(
            Alias = 'standardUser',
            Email = 'standaruser@testclasses.com',
            EmailEncodingKey='UTF-8',
            LastName='Standard',
            LanguageLocaleKey='en_US',
            LocaleSidKey='en_US',
            ProfileId = standarProfile.Id,
            TimeZoneSidKey='America/Los_Angeles',
            UserName='standarduser@testclasses.com'
        );

        //Create Account and Contact using run as the above user

        System.runAs(standardUser) {
            Account anAccount = new Account(
                Name = 'TestAccount'
            );  
            insert anAccount;

            Contact aContact = new Contact(
                LastName = 'TestContact',
                AccountId = anAccount.Id
            );
            insert aContact;
        }
    }
    //Positive test case
    // 1. Update Account's Owner
    // 2. Verifi Contact Owner shoul get updated
    @isTest
    static void accountTriggerAfterUpdateTestPositive() {
        // Get the account and contact
        Account anAccount = [
            SELECT Id, OwnerId 
            FROM Account
            WHERE Name = 'TestAccount'
            LIMIT 1
        ];
        Contact aContact = [
            SELECT Id, OwnerId 
            FROM Contact
            WHERE ContactId = 'TestContact'
            LIMIT 1
        ];

        // Assert owner of account and contact are not same as the current owner
        System.assertNotEquals(System.UserInfo.getUserId(), anAccount.OwnerId, 'Owner should not be the same as the current user');
        System.assertEquals(System.UserInfo.getUserId(), aContact.OwnerId, 'Owner shoul not be the same');

        // Update the account owner
        Test.startTest();
            anAccount.OwnerId = System.UserInfo.getUserId();
            update anAccount;
        Test.stopTest();

        // Verify the contact should ve updated to the current owner
        Contact updatedContact = [
            SELECT Id, OwnerId
            FROM Contact
            WHERE ContactId = 'TestContact'
            LIMIT 1
        ];
        System.assertEquals(System.UserInfo.getUserId(), updatedContact, 'Contact Owner should be updated to the current user');

        // Now update the Account but keep the Owner same. Contact Owner should not get updated to Account Owner and both should remain different
        Test.startTest();
            anAccount.Type = 'Industry';
            update anAccount;
        Test.stopTest();
    }
}

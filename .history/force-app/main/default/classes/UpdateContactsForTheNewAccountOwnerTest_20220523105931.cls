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
                Name = 'TestContact'
            );
            insert aContact;
        }
    }
    //Positive test case
    // 1. Update Account's Owner
    // 2. Verifi Contact Owner shoul get updated
    @isTest
    static void accountTriggerAfterUpdateTestPositive() {
        //get the account and contact
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
    }
}

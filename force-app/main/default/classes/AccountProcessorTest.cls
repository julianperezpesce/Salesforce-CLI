@IsTest
private class AccountProcessorTest {
  @IsTest
  private static void testCountContacts() {

    Account newAccount = new Account(Name='Test Account');
    insert newAccount;

    Contact newContact1 = new Contact(FirstName ='Test',   LastName='Contact', AccountId=newAccount.Id);
    insert newContact1;

    Contact newContact2 = new Contact(FirstName='Test2',   LastName='Contact2', AccountId=newAccount.Id);
    insert newContact2;

    List<Id> accountIds = new List<Id>();
    accountIds.add(newAccount.Id);

    //Test
    Test.startTest();
    AccountProcessor.countContacts(accountIds);
    Test.stopTest();
  }
}
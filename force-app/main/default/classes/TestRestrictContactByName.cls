@isTest
public class TestRestrictContactByName {
    @isTest static void createBadContact() {

        Contact c = new Contact(FirstName='Julian', LastName='INVALIDNAME');


        Test.startTest();
        Database.SaveResult result = Database.insert(c, false);
        Test.stopTest();

        System.assert(!result.isSuccess());

    }
}
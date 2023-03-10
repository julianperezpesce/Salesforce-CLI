@isTest
private class LeadProcessorTest {
    @testSetup
    static void setup() {
        List<Lead> leads = new List<Lead>();
        
        // insert 10 accounts
        for (Integer i=0;i<200;i++) {
            leads.add(new Lead(LastName='Lead '+i, Company='Tested ok'));
        }
        insert leads;
        
    }
    @isTest static void test() {
        Test.startTest();
        LeadProcessor leadObject = new LeadProcessor();
        Id batchId = Database.executeBatch(leadObject);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        System.assertEquals(200, [select count() from Lead where LeadSource = 'Dreamforce']);
    }
}
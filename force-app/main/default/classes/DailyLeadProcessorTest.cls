@isTest
private class DailyLeadProcessorTest {
    // Dummy CRON expression: midnight on March 15.
    // Because this is a test, job executes
    // immediately after Test.stopTest().
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    static testmethod void testScheduledJob() {
        // Create some out of date Opportunity records
        List<Lead> leadsToAdd = new List<Lead>();
        List<Lead> leads = new List<Lead>();
        for (Integer i=0; i<200; i++) {
            Lead lead = new Lead(
                FirstName = 'Test' + i,
                LastName = 'Lead',
                Company = 'Test Company'
            );
            leads.add(lead);
        }
        insert leads;
        
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP,
            new DailyLeadProcessor());        
        Test.stopTest();

        // Now that the scheduled job has executed,
        // check that our Lead LeadSource are equal to 'Dreamforce'
        List<Lead> checkLeads = new List<Lead>();
        checkLeads = [SELECT Id
            FROM Lead
            WHERE LeadSource = 'Dreamforce'
            AND Company = 'Test Company'];
        System.assertEquals(200, checkLeads.size(), 'Leads were not created');
    }
}
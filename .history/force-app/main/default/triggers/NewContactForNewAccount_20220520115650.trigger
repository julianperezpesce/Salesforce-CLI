trigger NewContactForNewAccount on Account (after insert) {
    if(Trigger.isAfter && Trigger.isInsert) {
        List<Contact> contacts = new List.<Contact>();

        for(Account account : Trigger.new) {
            Contact aContact = new Contact(
                FirstName = account.FirstName + ' Con ' + 1,
                LastName = account.LastName + ' tact ' + 1,
                AccountId = account.Id
            );
            contacts.add(aContact);
        }
        insert contacts;
    }
}
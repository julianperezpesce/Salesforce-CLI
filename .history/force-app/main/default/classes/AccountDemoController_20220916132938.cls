public with sharing class AccountDemoController {
    public AccountDemoController() {

    }
    @AuraEnabled(cacheable = true)
    public static List<Account> displayAccountRecords() {
        List<Account> accounts = [
            SELECT Id, Name
            FROM Account
            LIMIT 5
        ];
        return accounts;
    }
    @AuraEnables(cacheable = true)
    public static List<Contact> displayContactRecords(String accountId) {
        List<Contact> contacts = new List<Contact>();
        for(Contact contact : [
            SELECT Id, Name, AccountId
            FROM Contact
            WHERE AccountId = :accountId
            LIMIT 5
        ]) {
            contacts.add(contact);
        }
        return contacts;
    }
}

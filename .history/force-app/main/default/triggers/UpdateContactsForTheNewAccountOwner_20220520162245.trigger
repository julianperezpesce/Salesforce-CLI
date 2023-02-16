trigger UpdateContactsForTheNewAccountOwner on Account (after update) {
    if(Trigger.isAfter && Trigger.isUpdate) {
        List<Id> accountIds = new List<Id>();
        //to handle bulk operations, traverse through each account which is updated
        //verify if the Owner is changed or not the add its ID in accountIds

        for(Account account : Trigger.new) {
            if(account.OwnerId != Trigger.oldMap.get(account.Id).OwnerId) {
                accountIds.add(account.Id);
            }
        }
        //Check if at least 1 account was updated with new owner
        if(accountIds.size() != 0) {
            //Get list of all the contacts whose account's owner was changed
            List<Contact> contacts = [
                SELECT Id, OwnerId, AccountId
                FROM Contact
                WHERE AccountId IN :accountIds
            ];
            //Get the Owner Id valie from newMap of Accounts and update the contact¿s Owner
            for(Contact contact : contacts) {
                contact.OwnerId = Trigger.newMap.get(contact.AccountId).OwnerId;
            }
            update contacts;
        }   
    }
}
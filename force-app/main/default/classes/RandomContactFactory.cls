public class RandomContactFactory {

    public static List<Contact> generateRandomContacts(Integer numberOfContacts, String contactLastName ) {
        List<Contact> contactList = new List<Contact>();

        for(Integer i=0; i < numberOfContacts; i++) {
            Contact contact = new Contact(FirstName='Test ' + i, LastName=contactLastName);
            contactList.add(contact);
        }

        return contactList;
    }
    
}
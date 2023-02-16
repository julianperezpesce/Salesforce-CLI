public class ContactSearch {
    public static List<Contact> searchForContacts(String lastName, String mailingPostalCode) {
        
        Contact[] getCont = [
            SELECT Id, Name
            FROM Contact
            WHERE (LastName=:lastName AND MailingPostalCode=:mailingPostalCode)
        ];
        return getCont;
    }
}
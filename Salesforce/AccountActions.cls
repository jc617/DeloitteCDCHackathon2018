public without sharing class AccountActions 
{
    public static void updateContact ( List<Account> newAccount)
    {
        List<Contact> contactList = new List<Contact>();
        for(Account a : newAccount) {
     
     	Contact newContact = new Contact(ExternalID__c= a.Id, LastName = a.Name);
        contactList.add(newContact);
        
            }
        insert contactList;
    }
}
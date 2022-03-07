public class AutoUpdateContact {
    
    @InvocableMethod
    public static void updateAddressAndSendMail(){        
        List<Contact> contactlst = new List<Contact>();
        Set<ID> contactId = new Set<ID>();
        for(Contact contacts: contactlst){
            contactId.add(contacts.AccountId);
        }
        List<Contact> contactListToUpdate = new List<Contact>();
        List<Account> accountlst = [SELECT Id, BillingAddress FROM Account WHERE ID IN: contactId];
        for(Account account :accountlst){
            for(Contact contacts: contactlst){
                if(account.Id == contacts.AccountId){
                    Contact contactToUpdate = new Contact();
                    contactToUpdate.Id = contacts.Id;
                    contactToUpdate.MailingCity = account.BillingCity;
                    contactToUpdate.MailingCountry = account.BillingCountry;
                    contactToUpdate.MailingState = account.BillingState;
                    contactToUpdate.MailingStreet = account.BillingStreet;
                    contactToUpdate.MailingPostalCode = account.BillingPostalCode;
                    contactListToUpdate.add(contactToUpdate);
                }
            }
            database.update(contactListToUpdate);
        }
        List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage sendmail = new Messaging.SingleEmailMessage();
        List<Contact> emailList = [SELECT Id,Email FROM Contact];
        for(Contact contacts : emailList){
            sendmail.setHtmlBody('Mail Sent To Candidate');
            sendmail.setTargetObjectId(contacts.Id);
            mailList.add(sendMail); 
        }
        Messaging.sendEmail(mailList);
    }
}
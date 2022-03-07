public class ContactSendMail {
    
    @InvocableMethod
    public static void sendMail(){
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
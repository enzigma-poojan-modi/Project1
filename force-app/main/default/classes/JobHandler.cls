public class JobHandler {

    //Task 3
    public static void checkJobStatus(list<Job_Poojan__c> lstJob){
        for(Job_Poojan__c job: lstJob){
            if(job.Active__c == True){
                job.addError('This Job is active and can not be deleted');
            }
        }
    }
    
    //Task4
    public static void jobAutoDeactive(list<Job_Poojan__c> lstJob){
        for(Job_Poojan__c job : lstJob){
            if(job.Number_of_Positions__c == job.Hired_Applicants__c){
                job.Active__c = false;    
            }
        }
    }
    
    //Task5
    public static void sendMail(list<Job_Poojan__c> lstJob){
        List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage sendmail = new Messaging.SingleEmailMessage();
        Set<Id> jobmanagerID = new Set<Id>();
        for(Job_Poojan__c jobs : lstJob){
            if(jobs.Manager__c != Null){
                jobmanagerID.add(jobs.Manager__c);
            }
        }
        DateTime DT ;
        Map<ID, Job_Poojan__c> managerId = new Map<ID, Job_Poojan__c>();
        List<String> managerEmail = new List<String>() ;
        List<Contact> managerList = [SELECT Name , Email FROM Contact WHERE Id IN :jobmanagerID];
        for(Job_Poojan__c job : lstJob){
            if(job.Number_of_Positions__c == job.Hired_Applicants__c){
                managerId.put(job.Manager__c, job);
                DT = Date.valueOf(job.LastModifiedDate);
            }
        }
        if(managerId != Null){
            for(Contact managerlst : managerList) {
                if(managerId.containskey(managerlst.Id)){
                    managerEmail.add(managerlst.Email);
                    sendmail.setSubject('Update on Hired Candidates');
                    sendmail.setHtmlBody('All required candidate has been hired for this job on '+ DT);
                    sendmail.setToAddresses(managerEmail);
                    mailList.add(sendMail);                }
            }          
            Messaging.sendEmail(mailList);
        }
    }
    
    //Task6
    public static void updateJobStatus(list<Job_Poojan__c> lstJob){
        List<Job_Poojan__c> updateStatus = new List<Job_Poojan__c>();
        for(Job_Poojan__c job : lstJob ){
            if(job.Active__c == False && job.Number_of_Positions__c > job.Hired_Applicants__c){
                Job_Poojan__c newStatus = new Job_Poojan__c();
                newStatus.Id = job.Id;
                newStatus.Active__c = True;
                updateStatus.add(newStatus);
            }
        }  
        Database.update(updateStatus);
    }
}
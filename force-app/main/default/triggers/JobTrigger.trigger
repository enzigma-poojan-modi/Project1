trigger JobTrigger on Job_Poojan__c (before insert, after insert, after update, before update, before delete) {
    
   /* if(!SwitchTriggers__c.getInstance().IsActive__c) {
        System.debug('Bypassing trigger due to custom setting');
        return;
    }*/
    if(Trigger.isBefore && Trigger.isDelete){
        JobHandler.checkJobStatus(Trigger.old);  // Display error if user tries to delete a job which is active 
    }
    if(Trigger.isBefore && Trigger.isUpdate){
        JobHandler.jobAutoDeactive(Trigger.new); // Change status of job to not active when Hired_candidates equals number of position
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        
        JobHandler.sendMail(Trigger.new);       // Send mail to manager when Hired Students = Number of position
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        JobHandler.updateJobStatus(Trigger.new); // After updation of record if Number of postion is greater thn hired candidates change status to active
    }
    
}
trigger CandidateTrigger on Candidate_Poojan__c (before insert, after insert, after update, before update) {
    
    SwitchTriggers__c deactivateTrigger = SwitchTriggers__c.getInstance('CandidateTrigger');
    //if(deactivateTrigger.IsActive__c == True) {
        System.debug('Bypassing trigger due to custom setting');
        
        if(Trigger.isbefore && Trigger.isInsert){
            CandidateHandler.expectedSalary(Trigger.new);       // Checks while creating record if you missed expected salary field displays error 
        }
        if(Trigger.isbefore && Trigger.isInsert){
            CandidateHandler.checkActive(Trigger.new);          // Displays error if someone applies for job that is not active
        }
        if(Trigger.isAfter && Trigger.isInsert){
            CandidateHandler.checkDate(Trigger.new);            // Updates date to today's date before saving,
        }
        if(Trigger.isAfter && Trigger.isInsert){
            CandidateHandler.totalExpectedSalary(Trigger.new);
        }
        if(Trigger.isAfter && Trigger.isInsert){
            CandidateHandler.hiredExpectedSalary(Trigger.new);
        }
    //}
}
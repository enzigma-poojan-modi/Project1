public class CandidateHandler {
    //Task T1 A
    public static void expectedSalary(list <Candidate_Poojan__c> lstCandidate){
        for(Candidate_Poojan__c candidate :lstCandidate){
            if(candidate.Expected_Salary__c == NULL || candidate.Expected_Salary__c == 0 ){
                candidate.addError('Expected Salary field is missing');
            }
        }
    }
    //Task T1 B
    public static void checkActive(list<Candidate_Poojan__c> lstCandidate){
        Set<Id> jobIds = new Set<Id>();
        for(Candidate_Poojan__c candidate :lstCandidate){
            if(candidate.Job__c != null) {
                jobIds.add(candidate.Job__c);
            }
        }
        List<Job_Poojan__c> joblist = [SELECT Id FROM Job_Poojan__c WHERE Id IN :jobIds AND Active__c =: false];
        for(Job_Poojan__c jobs:joblist ){ 
            for(Candidate_Poojan__c candidate :lstCandidate){
                if(candidate.Job__c == jobs.Id ){
                    candidate.addError('This Job is not active. You can not apply for this job');
                }
            }
        }
    }

    //Task 2
    public static void checkDate(list<Candidate_Poojan__c> lstCandidate){
        List<Candidate_Poojan__c> lstCandidatesToUpdate= new List<Candidate_Poojan__c>();
        for(Candidate_Poojan__c candidate: lstCandidate){
            Candidate_Poojan__c candidateToUpdate = New Candidate_Poojan__c();
            candidateToUpdate.Id = candidate.Id;
            candidateToUpdate.Application_Date__c = Date.ValueOf(candidate.CreatedDate);
            lstCandidatesToUpdate.add(candidateToUpdate);
        }
        database.update(lstCandidatesToUpdate);	
    }
    
    public static void totalExpectedSalary(list<Candidate_Poojan__c> lstCandidate){
        Double sum = 0;
        Set<Id> jobIds = new Set<Id>();
        for(Candidate_Poojan__c candidate :lstCandidate){
            if(candidate.Job__c != null) {
                jobIds.add(candidate.Job__c);
            }
        }
        List<Job_Poojan__c> joblist = [SELECT Id, TotalExpectedSalary__c, (SELECT Expected_Salary__c FROM Candidate_Poojans__r) FROM Job_Poojan__c WHERE Id IN :jobIds];
        for(Job_Poojan__c job: joblist){
            sum = 0;
            for(Candidate_Poojan__c candidate: job.Candidate_Poojans__r){                
                sum = sum + candidate.Expected_Salary__c;    
            }
            job.TotalExpectedSalary__c = sum;
        }
        Database.update(joblist);
    }
    
    public static void hiredExpectedSalary(list<Candidate_Poojan__c> lstCandidate){
        Set<Id> jobIds = new Set<Id>();
        for(Candidate_Poojan__c candidate :lstCandidate){
            if(candidate.Job__c != null) {
                jobIds.add(candidate.Job__c);
            }
        }
        Decimal hiredsum = 0;
        Map<Id, Job_Poojan__c> joblist = new Map<Id, Job_Poojan__c>([SELECT Id, HiredTotalExpectedSalary__c, (SELECT Expected_Salary__c FROM Candidate_Poojans__r WHERE Status__c = 'Hired') FROM Job_Poojan__c WHERE Id IN :jobIds]);
        for(Job_Poojan__c job: joblist.values()){
            hiredsum = 0;
            for(Candidate_Poojan__c candidate :job.Candidate_Poojans__r){              
                    hiredsum = hiredsum + candidate.Expected_Salary__c;
            }
            job.HiredTotalExpectedSalary__c = hiredsum;            
        }
        Database.update(joblist.values());
    }
}
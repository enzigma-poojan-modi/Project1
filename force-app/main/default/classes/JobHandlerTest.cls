@isTest
public class JobHandlerTest {

    @TestSetup
    public static void setup(){
         List<Job_Poojan__c> jobs = new List<Job_Poojan__c>(); 
        for(integer i = 0; i < 2; i++ ){
            Job_Poojan__c job = new Job_Poojan__c();
            if(i == 0){
                job.Active__c = TRUE; 
            }
            else{
                job.Active__c = FALSE;
            }      
            job.Number_of_Positions__c = 2;
            job.Job_Type__c = 'Admin';
            job.Required_Skills__c = 'Networking';
            job.Qualification_Required__c = 'BE';
            job.Certification_Required__c = 'CISCO';
            jobs.add(job);
        }
        system.debug('jobs'+jobs);
        insert jobs;        
    }
    
    @isTest
    static void testJobStatus(){   
        List<Job_Poojan__c> job =[SELECT Id FROM Job_Poojan__c WHERE Active__c = true];
        List<Database.DeleteResult> result = Database.delete(job, false);
        system.debug('result'+result);
        for(Database.DeleteResult res: result){
            system.assertEquals(false, res.isSuccess());
            system.assertNotEquals(0, res.getErrors().size());
        }
    }
    
    @isTest
    static void testJobAutoDeactive(){
        Job_Poojan__c job =[SELECT Id, Number_of_Positions__c,Hired_Applicants__c FROM Job_Poojan__c WHERE Active__c = true];
        List<Candidate_Poojan__c> candidateList = new  List<Candidate_Poojan__c>();
        for(integer i=0; i<2 ; i++){
            Candidate_Poojan__c candidate = new Candidate_Poojan__c();
            candidate.First_Name__c = ('Mike'+i);
            candidate.Last_Name__c = ('Jonas'+i);
            candidate.Email__c = ('MJ'+i+'@j.com');
            candidate.Country__c = 'India';
            candidate.State__c = 'Gujrat';
            candidate.Status__c ='Hired';
            candidate.Expected_Salary__c = 500;    
			candidate.Application_Date__c = Date.Today();
            candidate.Job__c = job.Id;
            candidateList.add(candidate);
        }	
        List<Database.SaveResult> result = Database.insert(candidateList, false);        
        Job_Poojan__c newJob =[SELECT Id, Active__c,Number_of_Positions__c,Hired_Applicants__c FROM Job_Poojan__c WHERE Id =: job.Id];      
        system.debug('job'+newJob);
        for(Database.SaveResult res: result){
        system.equals(newJob.Number_of_Positions__c , newJob.Hired_Applicants__c);
        system.assertEquals(false, newJob.Active__c);
        }   
    }
    
    @isTest
    static void testSendMail(){
        Job_Poojan__c job =[SELECT Id, Number_of_Positions__c,Hired_Applicants__c FROM Job_Poojan__c WHERE Active__c = true];
        List<Candidate_Poojan__c> candidateList = new  List<Candidate_Poojan__c>();
        for(integer i=0; i<2 ; i++){
            Candidate_Poojan__c candidate = new Candidate_Poojan__c();
            candidate.First_Name__c = ('Mike'+i);
            candidate.Last_Name__c = ('Jonas'+i);
            candidate.Email__c = ('MJ'+i+'@j.com');
            candidate.Country__c = 'India';
            candidate.State__c = 'Gujrat';
            candidate.Status__c ='Hired';
            candidate.Expected_Salary__c = 500;    
			candidate.Application_Date__c = Date.Today();
            candidate.Job__c = job.Id;
            candidateList.add(candidate);
        }
        List<Database.SaveResult> result = Database.insert(candidateList, false);
        Job_Poojan__c newJob =[SELECT Id, Active__c,Number_of_Positions__c,Hired_Applicants__c FROM Job_Poojan__c WHERE Id =: job.Id];      
        for(Database.SaveResult res: result){
        system.equals(newJob.Number_of_Positions__c , newJob.Hired_Applicants__c);
        system.assertEquals(false, newJob.Active__c);
        }
    }
    
    @isTest
    static void testChangeStatus(){
        Job_Poojan__c job =[SELECT Id, Active__c,Number_of_Positions__c,Hired_Applicants__c FROM Job_Poojan__c WHERE Active__c = true];
        List<Candidate_Poojan__c> candidateList = new  List<Candidate_Poojan__c>();
        for(integer i=0; i<2 ; i++){
            Candidate_Poojan__c candidate = new Candidate_Poojan__c();
            candidate.First_Name__c = ('Mike'+i);
            candidate.Last_Name__c = ('Jonas'+i);
            candidate.Email__c = ('MJ'+i+'@j.com');
            candidate.Country__c = 'India';
            candidate.State__c = 'Gujrat';
            candidate.Status__c ='Hired';
            candidate.Expected_Salary__c = 500;    
			candidate.Application_Date__c = Date.Today();
            candidate.Job__c = job.Id;
            candidateList.add(candidate);
        }
        List<Database.SaveResult> result = Database.insert(candidateList, false);
        Job_Poojan__c updatePosition = new Job_Poojan__c(); 
        updatePosition.Number_of_Positions__c = 3;
        updatePosition.Id = job.Id;
        database.update(updatePosition);
        Job_Poojan__c newJob =[SELECT Id, Active__c,Number_of_Positions__c,Hired_Applicants__c FROM Job_Poojan__c WHERE Id =: job.Id];
        for(Database.SaveResult res: result){
        system.assertNotEquals(newJob.Number_of_Positions__c, newJob.Hired_Applicants__c);
        system.assertEquals(true, newJob.Active__c);
        }
    }
}
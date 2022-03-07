@isTest
public class CandidateHandlerTest {

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
            job.Number_of_Positions__c = 3;
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
    static void testExpectedSalary() {
        Job_Poojan__c job = [SELECT Id FROM Job_Poojan__c WHERE Active__c = true];
        system.debug('job'+job);
        List<Candidate_Poojan__c> candidateList = new  List<Candidate_Poojan__c>();
        for(integer i=0; i<2 ; i++){
            Candidate_Poojan__c candidate = new Candidate_Poojan__c();
            candidate.First_Name__c = ('Mike'+i);
            candidate.Last_Name__c = ('Jonas'+i);
            candidate.Email__c = ('MJ'+i+'@j.com');
            candidate.Country__c = 'India';
            candidate.State__c = 'Gujrat';
            candidate.Status__c ='Hired';
            candidate.Expected_Salary__c = 0;  
            candidate.Job__c = job.Id;
            candidateList.add(candidate);
        }
        List<Database.SaveResult> result = Database.insert(candidateList, false);
        system.debug('result'+result);
        for(Database.SaveResult res : result) {
            system.assertEquals(false, res.isSuccess());
            system.assertNotEquals(0, res.getErrors().size());
        }
        
    }
    
    @isTest
    static void testJobActive(){
    	Job_Poojan__c deactiveJob = [SELECT Id FROM Job_Poojan__c WHERE Active__c = false];
        List<Candidate_Poojan__c> candidateList = new  List<Candidate_Poojan__c>();
        for(integer i=0; i<3 ; i++){
            Candidate_Poojan__c candidate = new Candidate_Poojan__c();
            candidate.First_Name__c = ('Mike'+i);
            candidate.Last_Name__c = ('Jonas'+i);
            candidate.Email__c = ('MJ'+i+'@j.com');
            candidate.Country__c = 'India';
            candidate.State__c = 'Gujrat';
            candidate.Status__c ='Hired';
            candidate.Expected_Salary__c = 500;    
            candidate.Job__c = deactiveJob.Id;
            candidateList.add(candidate);
        }
        List<Database.SaveResult> result = Database.insert(candidateList, false);
        system.debug('result'+result);
        for(Database.SaveResult res : result) {
            system.assertEquals(false, res.isSuccess()); 
            system.assertNotEquals(0, res.getErrors().size()); 
        }
	}
    
    @isTest
    static void testDate(){     
        Job_Poojan__c activeJob = [SELECT Id FROM Job_Poojan__c WHERE Active__c = true];
        List<Candidate_Poojan__c> candidateList = new  List<Candidate_Poojan__c>();
        for(integer i=0; i<3 ; i++){
            Candidate_Poojan__c candidate = new Candidate_Poojan__c();
            candidate.First_Name__c = ('Mike'+i);
            candidate.Last_Name__c = ('Jonas'+i);
            candidate.Email__c = ('MJ'+i+'@j.com');
            candidate.Country__c = 'India';
            candidate.State__c = 'Gujrat';
            candidate.Status__c ='Hired';
            candidate.Expected_Salary__c = 500;    
            candidate.Application_Date__c = Date.newInstance(2021, 2, 17);
            candidate.Job__c = activeJob.Id;
            candidateList.add(candidate);
        }
        List<Database.SaveResult> result = Database.insert(candidateList, false);
        List<Candidate_Poojan__c> newcandidateList =[SELECT Id, Application_Date__c,CreatedDate FROM Candidate_Poojan__c];
        for(Candidate_Poojan__c candidate: newcandidateList){
            for(Database.SaveResult res : result) {
                system.assertEquals(Date.today() , candidate.Application_Date__c);     
            }
        }
    }
    
    @isTest
    static void testTotalExpectedSalary(){        
        Job_Poojan__c job = [SELECT Id, Total_Expected_Salary__c FROM Job_Poojan__c WHERE Active__c = true];
        List<Candidate_Poojan__c> candidateList = new  List<Candidate_Poojan__c>();
        for(integer i=0; i<3 ; i++){
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
        //List<Database.SaveResult> result = Database.insert(candidateList, false);
        Database.insert(candidateList);
        Job_Poojan__c joblist = [SELECT Id, TotalExpectedSalary__c FROM Job_Poojan__c WHERE Id =: job.Id];
                system.assertEquals(1500, joblist.TotalExpectedSalary__c);     
        }
    
    @isTest
    static void testTotalHiredExpectedSalary(){        
        Job_Poojan__c job = [SELECT Id, HiredTotalExpectedSalary__c FROM Job_Poojan__c WHERE Active__c = true];
        List<Candidate_Poojan__c> candidateList = new  List<Candidate_Poojan__c>();
        for(integer i=0; i<3 ; i++){
            Candidate_Poojan__c candidate = new Candidate_Poojan__c();
            candidate.First_Name__c = ('Mike'+i);
            candidate.Last_Name__c = ('Jonas'+i);
            candidate.Email__c = ('MJ'+i+'@j.com');
            candidate.Country__c = 'India';
            candidate.State__c = 'Gujrat';
            if( i < 2)
            	candidate.Status__c ='Hired';
            else
                candidate.Status__c ='Applied';
            candidate.Expected_Salary__c = 500;    
            candidate.Application_Date__c = Date.newInstance(2021, 2, 17);
            candidate.Job__c = job.Id;
            candidateList.add(candidate);
        }
        List<Database.SaveResult> result = Database.insert(candidateList, false);
        Job_Poojan__c joblist = [SELECT Id, HiredTotalExpectedSalary__c, (SELECT Expected_Salary__c,Status__c FROM Candidate_Poojans__r WHERE Status__c = 'Hired') FROM Job_Poojan__c WHERE Id =: job.Id];
            for(Database.SaveResult res : result) {
                system.assertEquals(1000, joblist.HiredTotalExpectedSalary__c);     
            }
        }
}
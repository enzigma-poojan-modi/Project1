public class JobController {
    
    public JobController(){
        job = new Job_Poojan__c ();
        //job = [select Description__c,Number_of_Positions__c,Expires_On__c,Active__c,Salary_Offered__c,Manager__c,Job_Type__c,Required_Skills__c,Qualification_Required__c,Certification_Required__c from Job_Poojan__c/* where id ='a015j00000BGCCM'*/];
    }
    
    public PageReference save() {
        insert job;
        return null;
    }
    
    public PageReference edit() {
        update job;
        return null;
    }
    
    public Job_Poojan__c job { get; set; }
}
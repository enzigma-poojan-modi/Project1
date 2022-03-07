public class ViewJobController {
    
    public List<Job_Poojan__c> records{get;set;}
    public List<Candidate_Poojan__c> crecords{get;set;}
    public List<String> cfields{get;set;}
    
    public ViewJobController(){
        records = [SELECT Name__c,Description__c,Number_of_Positions__c,Expires_On__c,Active__c,Salary_Offered__c,Manager__c,Job_Type__c,Required_Skills__c,Qualification_Required__c,Certification_Required__c FROM Job_Poojan__c];
        crecords = [SELECT Salutation__c,First_Name__c,Last_Name__c,Full_Name__c,DOB__c,Age__c,Email__c,Country__c,State__c,Status__c,Application_Date__c,Expected_Salary__c,Job__c FROM Candidate_Poojan__c];
        cfields = new List<String>{'First_Name__c','Last_Name__c','Email__c','State__c','Status__c','Job__c'};
            
            }
    
}
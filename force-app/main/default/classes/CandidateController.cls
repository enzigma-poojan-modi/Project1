public class CandidateController {
    
    public CandidateController(){
        candidate = new Candidate_Poojan__c();
        //candidate = [select Salutation__c,First_Name__c,Last_Name__c,DOB__c,Email__c,Country__c,State__c,Application_Date__c,Status__c,Expected_Salary__c,Job__c from Candidate_Poojan__c where id=:'a005j000008UTuN'];
    }
    
    public PageReference save() {
        insert candidate;
        return null;
    }
    
    public PageReference edit() {
        update candidate;
        return null;
    }
    
    public Candidate_Poojan__c candidate { get; set; }
}
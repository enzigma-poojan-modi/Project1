trigger HelloWorldTrigger on Account (before insert) {
    for(Account a : Trigger.New) {
        a.Description = 'New description';
        System.debug('Trigger.new'+Trigger.new);
        System.debug('Trigger.old'+Trigger.old);
    }   
}
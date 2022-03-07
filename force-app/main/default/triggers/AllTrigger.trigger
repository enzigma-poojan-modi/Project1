trigger AllTrigger on Account (before insert, after insert,before update,after update, before delete, after delete,after undelete ) {

    System.debug('Check');
    
    if(Trigger.isbefore && Trigger.isInsert){
        System.debug('Trigger.old before insert'+ Trigger.old);
        System.debug('Trigger.new before insert'+ Trigger.new);
        System.debug('Trigger.oldMap before insert'+ Trigger.oldMap);
        System.debug('Trigger.newMap before insert'+ Trigger.newMap);
    }
    
    else if(Trigger.isafter && Trigger.isInsert){
        System.debug('Trigger.old after insert'+ Trigger.old);
        System.debug('Trigger.new after insert'+ Trigger.new);
        System.debug('Trigger.oldMap after insert'+ Trigger.oldMap);
        System.debug('Trigger.newMap after insert'+ Trigger.newMap);
    }
    
    else if(Trigger.isbefore && Trigger.isUpdate){
        System.debug('Trigger.old before update'+ Trigger.old);
        System.debug('Trigger.new before update'+ Trigger.new);
        System.debug('Trigger.oldMap before update'+ Trigger.oldMap);
        System.debug('Trigger.newMap before update'+ Trigger.newMap);
    }
    
    else if(Trigger.isAfter && Trigger.isUpdate){
        System.debug('Trigger.old after update '+ Trigger.old);
        System.debug('Trigger.new after update '+ Trigger.new);
        System.debug('Trigger.oldMap after update '+ Trigger.oldMap);
        System.debug('Trigger.newMap after update '+ Trigger.newMap);
    }
    
    else if(Trigger.isBefore && Trigger.isDelete){
        System.debug('Trigger.old before delete '+ Trigger.old);
        System.debug('Trigger.new before delete '+ Trigger.new);
        System.debug('Trigger.oldMap before delete '+ Trigger.oldMap);
        System.debug('Trigger.newMap before delete '+ Trigger.newMap);
    }
    
    else if(Trigger.isAfter && Trigger.isDelete){
        System.debug('Trigger.old after delete '+ Trigger.old);
        System.debug('Trigger.new after delete '+ Trigger.new);
        System.debug('Trigger.oldMap after delete '+ Trigger.oldMap);
        System.debug('Trigger.newMap after delete '+ Trigger.newMap);
    }
    
     else if(Trigger.isAfter && Trigger.isUndelete){
        System.debug('Trigger.old after undelete '+ Trigger.old);
        System.debug('Trigger.new after undelete '+ Trigger.new);
        System.debug('Trigger.oldMap after undelete '+ Trigger.oldMap);
        System.debug('Trigger.newMap after undelete '+ Trigger.newMap);
    }
}
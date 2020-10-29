trigger LocationTrigger on Location__c (after insert) {
    
    if(trigger.isInsert && trigger.isAfter){
        for(Location__c l:trigger.new){
            LocationTriggerHandler.locationVerify(l.Id);
            
        }
    }
    
}
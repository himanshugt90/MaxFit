trigger EventSpeakerTrigger on EventSpeakers__c (before insert,before update) {
    
    Set<Id> eventInsert = new Set<Id>();
    Set<Id> speakerInsert = new Set<Id>();

    for(EventSpeakers__c evt:trigger.new){
        eventInsert.add(evt.Event__c);
        speakerInsert.add(evt.Speaker__c);
    }
    List<Event__c> event=[select Id,Start_DateTime__c from Event__c where Id in :eventInsert];
    Map<Id, DateTime> listOfEvents = new Map<Id, DateTime>();
    for(Event__c evt:event){
        listOfEvents.put(evt.Id,evt.Start_DateTime__c);
    }
  
    List<EventSpeakers__c> listOfRegistered=[select Id, Event__c,Speaker__c,Event__r.Start_DateTime__c from EventSpeakers__c where Speaker__c in :speakerInsert];
     
    
     for(EventSpeakers__c evt:trigger.new){
        DateTime booking=listOfEvents.get(evt.Event__c);
        if(!listOfRegistered.isEmpty()){
            for(EventSpeakers__c evty:listOfRegistered){
                if((booking==evty.Event__r.Start_DateTime__c) && (evt.Speaker__c==evty.Speaker__c )){
                    evt.Speaker__c.addError('already booked for this time');
                }   
             
            }
        }
           
        
     }
     

    
}
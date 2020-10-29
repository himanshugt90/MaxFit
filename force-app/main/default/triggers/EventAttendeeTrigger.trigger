trigger EventAttendeeTrigger on Event_Attendee__c (after insert) {

    EventAttendeeHandlerClass.sendConfirmationMail(trigger.new);
}
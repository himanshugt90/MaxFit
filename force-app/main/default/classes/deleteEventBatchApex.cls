global class deleteEventBatchApex implements Database.Batchable<sObject>
{
	global Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        String Query='Select Id, Name From Event__c Where Live__c = true AND End_Date_Time__c < LAST_N_MONTHS:2';
        return Database.getQueryLocator(Query);
    }
    global void execute(Database.BatchableContext bc, List<Event__c> records){
        // process each batch of records
        List<Database.DeleteResult> deleteResult=Database.delete(records);
        for(Database.DeleteResult dr:deleteResult){
            if(!dr.isSuccess()){
                List<Database.Error> errors=dr.getErrors();
                String errorInString = String.join(errors, ',');
                TransactionHandler.doHandleExceptionWithError(errorInString, 'DeleteEventBatch');
                
            }
        }
    }    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        List<String> toadd=new List<String>();
        toadd.add('Himanshu.gt90@gmail.com');
        mail.setToAddresses(toadd);
        mail.setSenderDisplayName('SFDCPanther');
        
        mail.setHtmlBody('The DeleteEventBatch Batch Prcoessing has been Completed');
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage> {mail};
        Messaging.sendEmail(emails);
    }  
}
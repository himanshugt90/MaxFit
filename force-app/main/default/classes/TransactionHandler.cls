public class TransactionHandler {

    public static void doHandleException(System.Exception ex, String processName) {
        Error_Log__c tranData=new Error_Log__c(
            Log_Details__c =ex.getStackTraceString() + '<br/> <bd>message is</bd> '+ex.getMessage()+'<br/>'+ex.getCause()+
                            '<br/>'+ex.getTypeName()+'<br/>'+ex.getLineNumber(),
            Lod_DateTime__c=System.Now(),
            Process_Name__c=  processName                
        );
        //use to check if user is having create access on error log object
    // if(Schema.sObjectType.Error_Log__c.isCreateable()){

    // }
        insert tranData;
    }
    
    public static void doHandleExceptionWithError(String errordata, String processName) {
        Error_Log__c tranData=new Error_Log__c(
            Log_Details__c = errorData,
            Lod_DateTime__c=System.Now(),
            Process_Name__c=  processName                
        );
        //use to check if user is having create access on error log object
    // if(Schema.sObjectType.Error_Log__c.isCreateable()){

    // }
        insert tranData;
    }

}
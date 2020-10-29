import { LightningElement,track } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import Event__c from '@salesforce/schema/Event__c';
import Name__c from '@salesforce/schema/Event__c.Name__c';
import Start_DateTime__c from '@salesforce/schema/Event__c.Start_DateTime__c';
import End_Date_Time__c from '@salesforce/schema/Event__c.End_Date_Time__c';
import Max_Seats__c from '@salesforce/schema/Event__c.Max_Seats__c';
import Event_Organizer__c from '@salesforce/schema/Event__c.Event_Organizer__c';
import Location__c from '@salesforce/schema/Event__c.Location__c';


export default class Event extends LightningElement {
    recordId;
    @track eventRecord={
        Name__c:'',
        Start_DateTime__c:null,
        End_Date_Time__c:null,
        Max_Seats__c:null,
        Event_Organizer__c:'',
        Location__c:''
    }
    handleInput(event){
        let value=event.target.value;
        let fieldName=event.target.name;
        this.eventRecord[fieldName]=value;
    }
    handleSelect(event){
        let value=event.detail.selectedRecordId;
        let fieldName=event.detail.parentfield;
        this.eventRecord[fieldName]=value;

    }
    handleClick(){
        const fields = {};
        fields[Name__c.fieldApiName] = this.eventRecord.Name__c;
        fields[Start_DateTime__c.fieldApiName] = this.eventRecord.Start_DateTime__c;
        fields[End_Date_Time__c.fieldApiName] = this.eventRecord.End_Date_Time__c;
        fields[Max_Seats__c.fieldApiName] = this.eventRecord.Max_Seats__c;
        fields[Event_Organizer__c.fieldApiName] = this.eventRecord.Event_Organizer__c;
        fields[Location__c.fieldApiName] = this.eventRecord.Location__c;

        const recordInput = { apiName: Event__c.objectApiName, fields };
        
        createRecord(recordInput)
            .then(result => {
                this.recordId = result.id;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record created ' + this.recordId,
                        variant: 'success',
                    }),
                );
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });
    }
}
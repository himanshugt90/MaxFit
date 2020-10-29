import { LightningElement ,track,api } from 'lwc';
import searchRecords from '@salesforce/apex/searchRecords.findRecords'
export default class SearchBoxComponent extends LightningElement {
    
    @api recordName;
    handleChange(event){

        let searchKey=event.target.value;
        let searchlabel=event.target.label;
        let searchEvent=new CustomEvent('search',{detail:{key:searchKey,label:searchlabel}});
        this.dispatchEvent(searchEvent);
        
    }   
}
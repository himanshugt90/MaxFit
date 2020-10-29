import { LightningElement, api, track } from 'lwc';
import searchRecords from '@salesforce/apex/searchRecords.findRecords'

export default class SearchDemo extends LightningElement {
 
 @api recordName="Account";   
 @api iconName= "standard:account"; 
 @track selectedRecordId; 
 @track records;
 @api fieldName="Name";
 @track selectedRecordVal;
    handleOnSearch(event){
        let searchKey = event.detail.key;
        let searchlabel = event.detail.label;

        console.log("this is parent --");
        console.log(searchKey+"="+searchlabel);


        searchRecords({
            objName:searchlabel,
            searchKey:searchKey,
            fieldName:this.fieldName
        }).then(data=>{
            if(data){
                let searchData=[];
                let parsedResponse=JSON.parse(data);
                console.log(JSON.stringify(parsedResponse[0]));

                let searchRecordList = parsedResponse[0];
                if(searchRecordList && searchRecordList.length>0){
                    for(let i=0;i<searchRecordList.length;i++){
                        searchData.push({value:searchRecordList[i].Name, key:searchRecordList[i].Id});
                        
                    }
                }else{
                    searchData=undefined ;
                }
                this.records=searchData;
                console.log(searchData);

                console.log("final");
                console.log(JSON.stringify(this.records));
                
            }
            
        }

        ).catch(error=>{
            this.records=undefined;
            window.console.log(' error ', error);
        });

    }
    handleSelect(event) {
        var selectedVal = event.detail.selId;
        this.selectedRecordVal = event.detail.selRec;
        this.selectedRecordId = selectedVal;
        let finalRecEvent = new CustomEvent('select', {
            detail: { selectedRecordId: this.selectedRecordId, parentfield: this.recordName }
        });
        console.log("final values=" + this.selectedRecordId+"="+this.recordName);
        this.dispatchEvent(finalRecEvent);
    }
    handleRemove(event){
        this.selectedRecordId=undefined;
        this.records=undefined;
        this.selectedRecordVal=undefined;
        let finalRecEvent = new CustomEvent('select', {
            detail: { selectedRecordId: this.selectedRecordId, parentfield: this.recordName }
        });
        console.log("final values=" + this.selectedRecordId+"="+this.recordName);
        this.dispatchEvent(finalRecEvent);
    }
}
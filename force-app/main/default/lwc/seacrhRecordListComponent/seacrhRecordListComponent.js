import { LightningElement,track,api } from 'lwc';

export default class SeacrhRecordListComponent extends LightningElement {
    
    @api id;
    @api value;
    @api iconName;
    handleSelect(){
        console.log("click" +this.value);
        console.log(this.id);

        let selectEvent = new CustomEvent("select", {
            detail: {
              selRec: this.value,
              selId: this.id
            }
          });
          this.dispatchEvent(selectEvent);
    }
}
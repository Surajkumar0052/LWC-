import { LightningElement } from 'lwc';
import Name_Field from '@salesforce/schema/Account.Name'
import Account_Object from '@salesforce/schema/Account'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { createRecord } from 'lightning/uiRecordApi';

export default class ExploreLDSHandlers extends LightningElement {
    
    name='';

    handleChange(event){
      this.name = event.target.value;
    }

    handleClick(){
      //1. Assign the values to the fields
      const fields = {};
      fields[Name_Field.fieldApiName] = this.name;

      //2. Configure the Object and fields
      const recInput = {
            apiName : Account_Object.objectApiName,
            fields
      }

      //3. createRecord()
     createRecord(recInput)
            .then(account => {
                  this.dispatchEvent(
                        new ShowToastEvent({
                              title:'Success',
                              message:account.id,
                              variant:'success'
                        })
                  );
            })
            .catch(error=>{
                  this.dispatchEvent(
                        new ShowToastEvent({
                              title:'Error',
                              message:error.body.message,
                              variant:'error'
                        })
                  );
            })
    }

}
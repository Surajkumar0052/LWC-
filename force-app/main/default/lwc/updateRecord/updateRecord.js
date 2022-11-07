import { LightningElement, wire } from 'lwc';
import getContact from '@salesforce/apex/updateRecord.getContact'
import First_Name from '@salesforce/schema/Contact.FirstName'
import Last_Name from '@salesforce/schema/Contact.LastName'
import Id_Field from '@salesforce/schema/Contact.Id'
import {ShowToastEvent} from 'lightning/platformShowToastEvent'
import { updateRecord } from 'lightning/uiRecordApi';

export default class UpdateRecord extends LightningElement {

      @wire(getContact) contact

      handleClick(){
            const fields = {};

            fields[Id_Field.fieldApiName] = this.contact.data.Id;
            fields[First_Name.fieldApiName] = this.template.querySelector("[data-field='FirstName']").value;
            fields[Last_Name.fieldApiName] = this.template.querySelector("[data-field='LastName']").value;

            // configuring the fields and object
            const recInput = {fields}

            updateRecord(recInput)   // this line gives us back a promise and once it is resolve we will use then
                        .then(()=>{
                              this.dispatchEvent(
                                    new ShowToastEvent({
                                          title:'success',
                                          message: 'record updated',
                                          variant:'success'
                                    })
                              );
                        })
                        .catch(error=>{
                              this.dispatchEvent(
                                    new ShowToastEvent({
                                          title:'error',
                                          message: error.body.message,
                                          variant:'error'
                                    })
                              );
                        })
      }
}
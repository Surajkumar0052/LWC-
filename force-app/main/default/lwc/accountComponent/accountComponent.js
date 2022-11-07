import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
//import {refreshApex} from '@salesforce/apex';

export default class ContactCreationLWC extends LightningElement {
@api recordId;
cardTitle='New Contact';

handleSuccess (){
const evt = new ShowToastEvent({
    title: "Success!",
    message: "The Contact's record has been successfully saved.",
    variant: "success",
});

eval("$A.get('e.force:refreshView').fire();");

this.dispatchEvent(evt);

}



}
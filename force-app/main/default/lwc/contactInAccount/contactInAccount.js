import { LightningElement } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
// import Account_Object from '@salesforce/schema/Account';
// import Name_Field from '@salesforce/schema/Account.Name';
import Contact_Object from '@salesforce/schema/Contact';
import First_Name_Field from '@salesforce/schema/Contact.FirstName';
import Last_Name_FIeld from '@salesforce/schema/Contact.LastName'
import Phone_Field from '@salesforce/schema/Contact.Phone';


export default class ContactInAccount extends LightningElement {
   
    objectApiName = Contact_Object;

    fields = [First_Name_Field, Last_Name_FIeld, Phone_Field];
    Handler(Event){
        const evt = new ShowToastEvent({
            title : 'Success',
            message : 'You have successfully inserted record',
            variant : 'success' 
    
        });
        this.dispatchEvent(evt);

    }
      

}
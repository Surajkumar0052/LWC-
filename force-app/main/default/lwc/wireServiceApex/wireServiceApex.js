import { api, LightningElement, wire } from 'lwc';
import fetchContact from '@salesforce/apex/getContact/fetchContact'

export default class WireServiceApex extends LightningElement {
    @api recordId;  

    @wire(fetchContact, {accountId : '$recordId'}) contacts  // $ gonna make sure that this property is a
    // dynamic reactive property and whenever we try to change this id it is going to re render the whole template
}
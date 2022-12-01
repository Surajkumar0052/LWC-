import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class DpRecForm extends LightningElement {
      @api recordId
      
      handleSuccess(){
            this.dispatchEvent(
                  new ShowToastEvent({
                        title: 'success',
                        message: 'Record updated!!',
                        variant: 'success',
                  }),
            );
      }
      handleError(){
            this.dispatchEvent(
                  new ShowToastEvent({
                        title: 'error',
                        message: 'Error in record update',
                        variant: 'error',
                  }),
            );
      }

}
import { LightningElement, track } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import getAccount from '@salesforce/apex/createAccount.getAccount';
import {NavigationMixin} from 'lightning/navigation';


export default class CreateAccountRec extends NavigationMixin(LightningElement) {
      @track accountid;
      @track error;
      @track loadSpinner = false;
      // @api insuranceDetailList;
      showMessage = false;


      @track objAccount = {
            'sobjectType': 'Account',
            'Name' : '',
            'Industry' : '',
            'Phone' : ''
      }


      // @track accountRecord = {
      //       Name : Name_Field,
      //       Industry : Industry_Field,
      //       Phone : Phone_Field
      // }
            

      handleChange(event) {
            // this.objInsurance[event.target.name] = event.target.value;
            this.objAccount[event.target.dataset.field] = event.detail.value;
            console.log(this.objAccount);
      }
            

      handleClick() {

            // Creating account record using apex 
            getAccount({ accObj : this.objAccount })
                  .then(result => {
                        console.log('Result : ' + JSON.stringify(result));
                        this.objAccount = {};
                        this.accountId = result.Id;
                        this.message = result;
                        window.console.log(this.accountId);

                        this.dispatchEvent(
                              new ShowToastEvent({
                                    title: 'Success',
                                    message: 'Account created',
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
                        console.log("error", JSON.stringify(error));
                  }); 

/*            const fields = {};
            fields[Name_Field.fieldApiName] = this.accountRecord.Name;
            fields[Phone_Field.fieldApiName] = this.accountRecord.Phone;
            fields[Industry_Field.fieldApiName] = this.accountRecord.Industry;

            const recInput = { apiName: Account_Object.objectApiName, fields };

            createRecord(recInput)
                  .then(acc => {
                        // this.loadSpinner = true;
                        this.accountid = acc.id;
                        console.log(acc.id);
                        this.dispatchEvent(
                              new ShowToastEvent({
                                    title : 'Success',
                                    message : 'Account created',
                                    variant : 'success',
                              }),
                        );
                        this.loadSpinner = false;
                        this.showMessage = true;
                        // this[NavigationMixin.Navigate]({
                        //       type: 'standard__recordPage',
                        //       attributes: {
                        //           recordId : acc.id,
                        //           objectApiName: 'Account',
                        //           actionName : 'view'
                        //       }
                        //   })
                  })
                  .catch(error => {
                        
                        this.dispatchEvent(
                              new ShowToastEvent({
                                    title : 'Error',
                                    message : error.body.message,
                                    variant : 'error',
                              }),
                        );
                  });
                  

*/
                  
      }
}
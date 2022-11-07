import { LightningElement, track } from 'lwc';
import sendMail from '@salesforce/apex/mailApiCallout.sendMail'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class SendEmail extends LightningElement {

      @track args = {
            email: '',
            subject: '',
            body: '',
            status: ''
      }

      fieldValidation() {
            try {
                  let isValid = true;

                  let inputFields = this.template.querySelectorAll('.validate');
                  console.log('InputFields : ', inputFields);
                  inputFields.forEach(inputField => {
                        console.log(inputField.checkValidity());
                        if (!inputField.checkValidity()) {
                              console.log('Field is not valid');
                              inputField.reportValidity();
                              isValid = false;
                        }
                        this.args[inputField.name] = inputField.value;
                        console.log('Check  : ', inputField.checkValidity());
                  });
                  return isValid;
            } catch (error) {
                  console.log('Error : ', error);
            }
      }

      showNotification(title, message, variant) {
            const evt = new ShowToastEvent({
                  title: title,
                  message: message,
                  variant: variant,
            });
            this.dispatchEvent(evt);
      }

      handleClick(event) {

            this.args[event.target.name] = event.target.value;
            console.log('values : ', this.args);

            if (this.fieldValidation()) {

                  sendMail({ email: this.args.email, subject: this.args.subject, body: this.args.body })
                        .then(result => {
                              console.log('result : ', result);
                              this.args.status = result;
                              if (result == 'OK') {
                                    this.showNotification('Success', 'Email Sent!!', 'success');

                              }
                              else if (result == 'Bad Request') {
                                    this.showNotification('ERROR', 'Email Not Sent!!', 'error');
                              }


                        }).catch(error => {
                              console.log('error', error);
                              this.showNotification('ERROR', error.body.message, 'error');
                        })
            }
            else {
                  return;
            }
      }
}
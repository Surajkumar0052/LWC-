import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class Calculator extends LightningElement {
      @track numbers = {
            Number1 : 0,
            Number2 : 0 ,
      }

      Result = 0 ;
      showResult = false;
     
      handlechange(event) {
            console.log(event.target.name);
            this.numbers[event.target.name] = event.target.value;


      }

      handleAddition() {
            this.showResult = true;
            this.Result = parseFloat(this.numbers.Number1) + parseFloat(this.numbers.Number2);
      }
      handleSubraction() {
            this.showResult = true;
            this.Result = parseFloat(this.numbers.Number1) - parseFloat(this.numbers.Number2);
      }
      handleMultiplication() {
            this.showResult = true;
            this.Result = parseFloat(this.numbers.Number1) * parseFloat(this.numbers.Number2);
      }
      handleDivision() {
            this.showResult = true;
            if(this.numbers.Number2 == 0){
                  console.log('Num3=2', this.numbers.Number2 );
                  this.dispatchEvent(
                        new ShowToastEvent({
                              title: 'Error',
                              message: 'Please enter number other than 0',
                              variant: 'error',
                        }),
                  );
                  
            }
            else{
                  
                  this.Result = parseFloat(this.numbers.Number1) / parseFloat(this.numbers.Number2);

            }
      }

}
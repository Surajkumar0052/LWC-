import { LightningElement, track } from 'lwc';

export default class LWCtable extends LightningElement {
@track input={
      firstInput : 0,
      secondInput : 0,
      thirdInput : 0,
      fourthInput : 0,
      fifthInput : 0,
      sixthInput : 0,
      sum1 : 0,
      sum2 : 0,
      sum3 : 0,
      value1 : 0,
      value2 : 0
};

@track options =[];
currentYear= new Date().getFullYear(); 
connectedCallback(){
      for(let i=0; i<=10; i++){
            this.options.push({label: String(this.currentYear-i ) ,value: String( this.currentYear-i )});            
      }
       
      console.log('options : ' , this.options);
}

handleChange(event) {
      this.input[event.detail.value] = event.detail.value;
      console.log(this.input);
  }

handlechange(event){
      
      this.input[event.target.name] = event.target.value;
      console.log(this.input);

      this.input.sum1 = parseFloat(this.input.firstInput) + parseFloat(this.input.fourthInput);
      this.input.sum1 = this.input.sum1 ? this.input.sum1 : 0;

      this.input.sum2 = parseFloat(this.input.secondInput) + parseFloat(this.input.fifthInput);
      this.input.sum2 = this.input.sum2 ? this.input.sum2 : 0;

      this.input.sum3 = parseFloat(this.input.thirdInput) + parseFloat(this.input.sixthInput);
      this.input.sum3 = this.input.sum3 ? this.input.sum3 : 0;


}

}
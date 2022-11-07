import { LightningElement,api, track} from 'lwc';

export default class LWCtableChild extends LightningElement {
      @api result;
      //We have to use track for objects and array type to track its value
      @track input={
                  firstinput:0,
                  secondinput:0,
                  thirdinput:0,
                  fourthinput:0,
                  fifthinput:0,
                  sixthinput:0,
                  result1 : 0,
                  result2 : 0,
                  result3 : 0,
                  result4 : 0,
                  result5 : 0,
                  result6 : 0
      }

      handlechange(event){
            this.input[event.target.name] = event.target.value;

            this.input.result1 = parseFloat(this.input.firstinput) * parseFloat(this.result.sum2);
            this.input.result1 = this.input.result1 ? this.input.result1 : 0;

            this.input.result2 = parseFloat(this.input.secondinput) * parseFloat(this.result.sum3);
            this.input.result2 = this.input.result2 ? this.input.result2 : 0;

            this.input.result3 = (parseFloat(this.input.result1)/parseFloat(this.input.thirdinput)).toFixed(2);
            this.input.result3 = this.input.result3 ? this.input.result3 : 0;

            this.input.result4 = (parseFloat(this.input.result2)/parseFloat(this.input.fourthinput)).toFixed(2);
            this.input.result4 = this.input.result4 ? this.input.result4 : 0;

            this.input.result5 = parseFloat(this.result.sum2) + parseFloat(this.input.result1) + parseFloat(this.input.result3);
            this.input.result5 = this.input.result5 ? this.input.result5 : 0;

            this.input.result6 = parseFloat(this.result.sum3) + parseFloat(this.input.result2) + parseFloat(this.input.result4);
            this.input.result6 = this.input.result5 ? this.input.result5 : 0;
      }



}
import { LightningElement } from 'lwc';

export default class Binding extends LightningElement {
      
      message  = 'Hello World';
      connectedCallback(){
            console.log('Hello');
      }

}
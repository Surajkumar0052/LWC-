import { LightningElement } from 'lwc';
import {NavigationMixin} from 'lightning/navigation'

export default class ButtonToInsuranceDetails extends NavigationMixin(LightningElement) {
      handleClick(){
            
                  
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attributes: {
                apiName: 'Insurance_Details_Component'
            }
        })
              
      }
}
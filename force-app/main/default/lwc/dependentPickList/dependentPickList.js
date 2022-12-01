import { LightningElement, track, api } from 'lwc';
import getFieldDependencies from '@salesforce/apex/DependentPicklistHandler.getFieldDependencies';
import getRegion from '@salesforce/apex/DependentPicklistHandler.getRegion';
import updateRegionRecord from '@salesforce/apex/DependentPicklistHandler.updateRegionRecord';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class DependentPickList extends LightningElement {
      @api recordId;
      @track values = {
            regionValue: '',
            zoneValue: '',
            regionOptions: [],
            zoneOptions: [],
            disableBtn: true,
            btnClass: 'btn1'
      }

      connectedCallback() {
            this.invokeApexMethods();
      }

      async invokeApexMethods() {
            try {
                  const result1 = await getRegion({ Id: this.recordId })
                        .then(result => {
                              console.log('record fetched : ', result);
                              if (result != 'Null') {
                                    this.values.regionValue = result.Regions__c;
                                    this.values.zoneValue = result.Zone__c;

                              }
                              else {
                                    console.log('Record fetching error : ', result);
                              }
                        })
                        .catch(error => {
                              console.log('error : ', error);
                        });
                  console.log('Method1 result: ' + result1);

                  this.fetchPickList(this.values.regionValue);

            } catch (error) {
                  console.log(error);
            }
      }


      fetchPickList(regValue) {
            try {
                  getFieldDependencies()
                        .then(result => {
                              console.log('success : ', result);
                              let reignArr = [];
                              for (let key in result) {
                                    reignArr.push({ label: key, value: key });

                                    if (regValue == key) {
                                          console.log('Key matched 1 : ', result[key]);
                                          let zoneArr = [];
                                          for (let val in result[key]) {
                                                zoneArr.push({ label: result[key][val], value: result[key][val] });
                                          }
                                          this.values.zoneOptions = zoneArr;
                                    }
                              }
                              this.values.regionOptions = reignArr;
                        })
                        .catch(error => {
                              console.log('Fetching dependency error : ', error);
                        })
            }
            catch {
                  console.log('Error in getFieldDependencies method');
            }
      }

      showToast(title, message, variant) {
            this.dispatchEvent(
                  new ShowToastEvent({
                        title: title,
                        message: message,
                        variant: variant,
                  }),
            );
      }

      handleChange(event) {
            console.log('Tets : ', this.values.regionOptions.hasOwnProperty('APAC'));
            this.values.btnClass = 'btn2';
            this.values.disableBtn = false;
            this.values.zoneValue = null;
            let getDependentPicklistValues = event.target.value;

            this.fetchPickList(getDependentPicklistValues);

            this.values[event.target.name] = event.detail.value;
      }

      handleClick() {
            try {

                  const isInputCorrect = [...this.template.querySelectorAll('.validate')].reduce((validSoFar, inputField) => {
                        inputField.reportValidity();
                        console.log('checking field validity');
                        return validSoFar && inputField.checkValidity();
                  }, true);

                  if (isInputCorrect) {
                        updateRegionRecord({ Id: this.recordId, regValue: this.values.regionValue, zoneValue: this.values.zoneValue })
                              .then(result => {
                                    console.log('res : ', result);
                                    eval("$A.get('e.force:refreshView').fire();");
                                    if (result == 'success') {
                                          eval("$A.get('e.force:refreshView').fire();");
                                          this.showToast('Success', 'Record Updated', 'success');
                                          this.values.disableBtn = true;

                                    }
                              })
                              .catch(error => {
                                    console.log('Error : ', error);
                                    this.showToast('Error', errora.body.message, 'error');
                              })
                  }
                  else {
                        console.log('Field inputs are not valid ');
                        // this.showToast('Error', 'Inputs are not valid' , 'error');
                  }
            }
            catch (error) {
                  console.log('Error in creating rec : ', error);
                  this.showToast('Error', error.body.message, 'error');
            }
      }

}
import { api, LightningElement, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';


import Insurance_Object from '@salesforce/schema/Insurance_Details__C';
import Insurance_Waiver_Field from '@salesforce/schema/Insurance_Details__c.Insurance_Waiver__c';
import Insured_Person_Field from '@salesforce/schema/Insurance_Details__c.Insured_Person_Name__c';
import Nominee_Name_Field from '@salesforce/schema/Insurance_Details__c.Nominee_Name__c';
import Nominee_Relationship_Type_Field from '@salesforce/schema/Insurance_Details__c.Nominee_Relationship_Type__c';
import Nominee_Relationship_with_Insured_Person_Field from '@salesforce/schema/Insurance_Details__c.Nominee_Relationship_with_Insured_Person__c';
import Nominee_KYC_ID_Type_Field from '@salesforce/schema/Insurance_Details__c.Nominee_KYC_ID_Type__c';
import Insurance_Requirement_Field from '@salesforce/schema/Insurance_Details__c.Insurance_Requirement__c';
import Insurance_Medical_Test_Result_Field from '@salesforce/schema/Insurance_Details__c.Insurance_Medical_Test_Result__c';

import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import createInsurance from '@salesforce/apex/createInsuranceRecord.createInsurance';
import getUploadedFileId from '@salesforce/apex/createInsuranceRecord.getUploadedFileId';
import getInsuranceDetailsRecords from '@salesforce/apex/InsuranceDetailsController.getInsuranceDetailsRecords';
import { refreshApex } from '@salesforce/apex';

export default class InsuranceDetails extends NavigationMixin(LightningElement) {
      @api insuranceId = 0;

      fileData = {};
      disableSaveBtn = false;
      loadSpinner = false;
      showCancelBtn = false;

      @track showExistingRecords = true;
      @track showCreateRecordtable = true;

      @track existingInsuranceDetailList = [];

      @track InsuranceIdWithDocumentId = new Map();

      _wiredResult;

      currentEditInsuranceDetailId = null;

      @track insuranceDetailRecord = {
            'Nominee_Relationship_Type__c': '',
            'Nominee_Relationship_with_Insured_Person__c': ''
      }


      @track objInsurance = {
            'sobjectType': 'Insurance_Details__c',
            'Id': '',
            'Insurance_Waiver__c': '',
            'Insured_Person_Name__c': '',
            'Insured_Person_Date_of_Birth__c': '',
            'Nominee_Name__c': '',
            'Nominee_Relationship_Type__c': '',
            'Nominee_Relationship_with_Insured_Person__c': '',
            'Nominee_KYC_ID_Type__c': '',
            'Nominee_Type__c': '',
            'Part_of_Loan__c': '',
            'Not_Part_of_Loan__c': '',
            'Nominee_KYC_ID_No__c': '',
            'Nominee_DOB_as_per_KYC__c': '',
            'Insurance_Requirement__c': '',
            'Insurance_Medical_Test_Result__c': '',
      }


      @wire(getInsuranceDetailsRecords)
      existingInsuranceRecords(value) {
            const { data, error } = value;
            this._wiredResult = value;
            if (data) {
                  console.log(data);
                  this.existingInsuranceDetailList = data;
            } else if (error) {
                  console.log(error);
            };
      }


      @track nomineeTypeValue = [];

      get options() {
            return [
                  { label: 'Part of Loan', value: 'Part of Loan' },
                  { label: 'Not part of loan', value: 'Not part of loan' },
            ];
      }

      @wire(getPicklistValues, {
            recordTypeId: '012000000000000AAA',
            fieldApiName: Insurance_Waiver_Field
      }) InsuranceWaiverOptions;

      @wire(getPicklistValues, {
            recordTypeId: '012000000000000AAA',
            fieldApiName: Insured_Person_Field
      }) InsuredPersonNameOptions;

      @wire(getPicklistValues, {
            recordTypeId: '012000000000000AAA',
            fieldApiName: Nominee_Name_Field
      }) NomineeNameOptions;

      @wire(getPicklistValues, {
            recordTypeId: '012000000000000AAA',
            fieldApiName: Nominee_Relationship_Type_Field
      }) NomineeRelationshipTypeOptions;

      @wire(getPicklistValues, {
            recordTypeId: '012000000000000AAA',
            fieldApiName: Nominee_Relationship_with_Insured_Person_Field
      }) NomineeRelationshipIPOptions;

      @wire(getPicklistValues, {
            recordTypeId: '012000000000000AAA',
            fieldApiName: Nominee_KYC_ID_Type_Field
      }) NomineeKYCIDTypeOptions;

      @wire(getPicklistValues, {
            recordTypeId: '012000000000000AAA',
            fieldApiName: Insurance_Requirement_Field
      }) InsuranceRequirementOptions;

// 2nd method to get picklist values and in markup we have to set just if:true InsuranceRequirementOptions.data and option only InsuranceRequirementOptions
      // @track InsuranceRequirementOptions;
      // @wire(getObjectInfo, { objectApiName: Insurance_Object })
      // objectInfo;

      // @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: Insurance_Requirement_Field })
      // considertype({ data, error }) {
      //       if (data) {
      //             this.InsuranceRequirementOptions = data.values;
      //       } else if (error) {
      //             console.log(error);
      //       }
      // }

      @wire(getPicklistValues, {
            recordTypeId: '012000000000000AAA',
            fieldApiName: Insurance_Medical_Test_Result_Field
      }) InsuranceMedicalTestResultOptions;


      addInsuranceDetail(){
            this.loadSpinner = true;
            this.showCreateRecordtable = true;
            this.loadSpinner = false;
            // this.objInsurance = null;

            this.insuranceDetailRecord = {};
            // this.reInitInsuranceDetail();
            this.currentEditInsuranceDetailId = null;
            this.getInsuranceDetails(null);
            this.fileErrMsg = '';
      }

      handleCancel(){
            // this.objInsurance = null;
            this.showCreateRecordtable = false;
      }

      handlechange(event) {
            this.objInsurance[event.target.dataset.field] = event.detail.value;
            console.log(this.objInsurance);
            console.log('Insurance Waiver : ', this.template.querySelector("lightning-combobox[data-field=Insurance_Waiver__c]").value);


            try {
                  console.log('IP Name : ', this.template.querySelector("lightning-combobox[data-field=Insured_Person_Name__c]").value);
                  console.log('Nominee : ', this.template.querySelector("lightning-combobox[data-field=Nominee_Name__c]").value);

                  if (this.template.querySelector("lightning-combobox[data-field=Insured_Person_Name__c]").value && this.template.querySelector("lightning-combobox[data-field=Nominee_Name__c]").value) {
                        if (this.template.querySelector("lightning-combobox[data-field=Insured_Person_Name__c]").value == this.template.querySelector("lightning-combobox[data-field=Nominee_Name__c]").value) {
                              this.dispatchEvent(
                                    new ShowToastEvent({
                                          title: 'Error',
                                          message: 'Insured Person Name and Nominee Name cannot be same!!!',
                                          variant: 'error',
                                    }),
                              );
                              this.template.querySelector("lightning-combobox[data-field=Nominee_Name__c]").value = '';
                              this.template.querySelector("lightning-combobox[data-field=Insured_Person_Name__c]").value = '';

                        }
                  }

                  if (event.target.dataset.field == 'Nominee_Type__c') {
                        if (event.detail.value.includes('Part of Loan')) {
                              this.nomineeTypeValue.push('Part of Loan');
                        }

                        if (event.detail.value.includes('Not part of loan')) {
                              this.nomineeTypeValue.push('Not part of loan');
                        }
                        console.log('nominee type', this.nomineeTypeValue[0]);
                  }

            }
            catch (error) {
                  console.log('Error in Nominee Name and IP name : ', error);
            }


            try {
                  if ((this.template.querySelector("lightning-combobox[data-field=Insurance_Waiver__c]").value) == 'Yes') {
                        this.template.querySelectorAll("lightning-input").forEach(item => {
                              item.required = false;
                              item.disabled = true;
                              item.value = null;
                        });
                        this.template.querySelectorAll("lightning-combobox").forEach(item => {
                              if (item.label != 'Insurance Waiver') {
                                    item.required = false;
                                    item.disabled = true;
                                    item.value = null;
                              }
                        });
                        this.template.querySelectorAll("lightning-checkbox-group").forEach(item => {
                              if (item.label != 'Insurance Waiver') {
                                    item.required = false;
                                    item.disabled = true;
                                    this.nomineeTypeValue = []
                              }
                        });


                  }

                  else if ((this.template.querySelector("lightning-combobox[data-field=Insurance_Waiver__c]").value) == 'No') {
                        this.template.querySelectorAll("lightning-input").forEach(item => {
                              item.required = true;
                              item.disabled = false;
                        });
                        this.template.querySelectorAll("lightning-combobox").forEach(item => {
                              if (item.label != 'Insurance Waiver') {
                                    item.required = true;
                                    item.disabled = false;
                              }
                        });
                        this.template.querySelectorAll("lightning-checkbox-group").forEach(item => {
                              if (item.label != 'Insurance Waiver') {
                                    item.required = true;
                                    item.disabled = false;
                              }
                        });
                  }

            }
            catch (error) {
                  console.log('Error in Waiver Validation : ', error);
            }


      }



      onFileUpload(event) {
            try {
                  const file = event.target.files[0];
                  var reader = new FileReader()
                  reader.onload = () => {
                        var base64 = reader.result.split(',')[1]
                        this.fileData = {
                              'filename': file.name,
                              'base64': base64,

                        }
                        console.log(this.fileData)
                  }
                  reader.readAsDataURL(file);
            }
            catch (error) {
                  console.log('File upload error : ', error);
            }
      }

      fieldValidation() {
            try {
                  let isValid = true;

                  let inputFields = this.template.querySelectorAll('.validate');
                  console.log('InputFields : ', inputFields);
                  inputFields.forEach(inputField => {
                        if (!inputField.checkValidity()) {
                              inputField.reportValidity();
                              isValid = false;
                        }
                        this.objInsurance[inputField.name] = inputField.value;
                  });
                  return isValid;
            } catch (error) {
                  console.log('Error : ', error);
            }
      }

      handleClick() {
            this.loadSpinner = true;

            console.log('nominee type : ', this.nomineeTypeValue);
            if (this.nomineeTypeValue.includes('Part of Loan')) {
                  this.objInsurance.Part_of_Loan__c = true;
            } else {
                  this.objInsurance.Part_of_Loan__c = false;
            }
            if (this.nomineeTypeValue.includes('Not part of loan')) {
                  this.objInsurance.Not_Part_of_Loan__c = true;
            } else {
                  this.objInsurance.Not_Part_of_Loan__c = false;
            }

            try {
                  if (this.fieldValidation()) {
                        // for new insurance detail record 
                        if (!this.objInsurance.Id) {
                              delete this.objInsurance['Id'];
                        }
                        this.loadSpinner = true;
                        createInsurance({
                              objInsurance: this.objInsurance,
                              base64: this.fileData.hasOwnProperty('base64') ? this.fileData.base64 : '',
                              filename: this.fileData.hasOwnProperty('filename') ? this.fileData.filename : '',
                              recId: ''

                        })
                              .then(result => {
                                    console.log('Result : ' + JSON.stringify(result));
                                    this.insuranceId = result.Id;
                                    console.log('res : ', result.Id);
                                    // this.objInsurance = null;
                                    refreshApex(this._wiredResult);

                                    this.loadSpinner = false;
                                    this.showCreateRecordtable = false;
                                    this.disableSaveBtn = true;
                                    this.dispatchEvent(
                                          new ShowToastEvent({
                                                title: 'Success',
                                                message: 'Account created',
                                                variant: 'success',
                                          }),
                                    );
                              })
                              .catch(error => {
                                    this.loadSpinner = false;
                                    this.dispatchEvent(
                                          new ShowToastEvent({
                                                title: 'Error creating record',
                                                message: error.body.message,
                                                variant: 'error',
                                          }),
                                    );
                                    console.log("error", JSON.stringify(error));
                              });

                  }

                  if (!this.fieldValidation()) {
                        this.loadSpinner = false;
                  }
            }
            catch (error) {
                  console.log("Record Creation Error : ", error);
            }

      }


      handleEdit(event) {
            try {
                  this.loadSpinner = true;
                  
                  this.showCancelBtn = true; 
                  this.showCreateRecordtable = true;
                  let index = event.currentTarget.dataset.index;

                  console.log('index : ', event.currentTarget.dataset.index);
                  console.log('id : ', event.currentTarget.dataset.id);
                  console.log('index', event.target.dataset.index, (JSON.stringify(this.existingInsuranceDetailList[event.target.dataset.index])));


                  let selectedData = JSON.parse(JSON.stringify(this.existingInsuranceDetailList[index]));
                  console.log('typeof ins req : ', typeof selectedData.Insurance_Requirement__c);
                  console.log('ins req option type : ', typeof this.InsuranceRequirementOptions[0]);

                  this.objInsurance.Insurance_Requirement__c = selectedData.Insurance_Requirement__c;
                  this.objInsurance.Insurance_Waiver__c = selectedData.Insurance_Waiver__c;
                  this.objInsurance.Insured_Person_Name__c = selectedData.Insured_Person_Name__c;
                  this.objInsurance.Insured_Person_Date_of_Birth__c = selectedData.Insured_Person_Date_of_Birth__c;
                  this.objInsurance.Nominee_Name__c = selectedData.Nominee_Name__c;
                  this.objInsurance.Nominee_DOB_as_per_KYC__c = selectedData.Nominee_DOB_as_per_KYC__c;
                  this.objInsurance.Nominee_KYC_ID_No__c = selectedData.Nominee_KYC_ID_No__c;
                  this.objInsurance.Nominee_KYC_ID_Type_Field = selectedData.Nominee_KYC_ID_Type_Field;
                  this.objInsurance.Insurance_Medical_Test_Result__c = selectedData.Insurance_Medical_Test_Result__c;
                  this.objInsurance.Nominee_Relationship_Type__c = selectedData.Nominee_Relationship_Type__c;
                  this.objInsurance.Nominee_Relationship_with_Insured_Person__c = selectedData.Nominee_Relationship_with_Insured_Person__c;
                  this.objInsurance.Nominee_KYC_ID_Type__c = selectedData.Nominee_KYC_ID_Type__c;
                  this.objInsurance.Id = selectedData.Id;
                  // this.currentEditInsuranceDetailId = selectedData.Id;

                  this.disableSaveBtn = false;

                  console.log('Existing List : ', this.existingInsuranceDetailList);

                  this.loadSpinner = false;


            } catch (error) {
                  console.log('HandleEdit error :  ', error.message);
            }


      }

      viewUploadedFile(event) {

            try{
            // let selectedData = JSON.parse(JSON.stringify(this.existingInsuranceDetailList[index]));
            // console.log('Id of doc : ', selectedData.Id);
            var insuranceId = this.existingInsuranceDetailList[event.target.dataset.index].sobject.id;
            console.log('File id : ', insuranceId);
            if (this.InsuranceIdWithDocumentId.has(selectedData.Id)) {
    
                this.navigateDocument(this.InsuranceIdWithDocumentId.get(insuranceId));
            } else {
    
                this.showLoader = true;
                getUploadedFileId({
                    parentId: this.InsuranceIdWithDocumentId.get(insuranceId),
                }).then((result) => {
    
                    console.log('getUploadedFileId  = ', JSON.stringify(result));
                    if (result.length > 0) {
                        this.navigateDocument(result[0].ContentDocumentId);
                        this.InsuranceIdWithDocumentId.set(insuranceId, result[0].ContentDocumentId);
                    }
                    this.showLoader = false;
    
                }).catch((error) => {
                    console.log('Document Id Error : ', error);
                    this.showLoader = false;
                });
            }
      }
      catch(error){
            console.log('View Doc Error : ' , error);
      }
    
        }
        navigateDocument(contentDocId) {
    
            this[NavigationMixin.Navigate]({
                type: 'standard__namedPage',
                attributes: {
                    pageName: 'filePreview'
                },
                state: {
                    selectedRecordId: contentDocId
                }
            })
    
        }
}
